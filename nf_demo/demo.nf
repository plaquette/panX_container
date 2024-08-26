#!/usr/bin/env nextflow




process panx_p {
    label 'q_demo'


    input:
    tuple val(key), path(folder_p)
    
    
    output:
    tuple val(key), path("${key}/vis"), emit: panx_out
 


    script:
    """

    panX.py -fn ${folder_p} -sl ${key} -t 2


    """
}



workflow{

    params.run = 'test'


    params.out = "$baseDir/out/"

    inputs =  Channel.fromPath("$baseDir/input/")

    inputs_key = inputs.map{it -> [it.name, it]}

    inputs_key | panx_p
    
    panx_p.out.view()

}