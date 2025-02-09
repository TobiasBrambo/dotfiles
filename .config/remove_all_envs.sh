for environment_name in $(conda env list | awk '{print $1}' | grep -v -e '^base' -e '^#' | tr '\n' ' ')
do
    echo "$environment_name"
    conda remove --name "$environment_name" --all -y
done
