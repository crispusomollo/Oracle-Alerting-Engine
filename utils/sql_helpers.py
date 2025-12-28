import subprocess

def run_scheduler_job(job_name):
    sql = f"""
    BEGIN
      DBMS_SCHEDULER.run_job(
        job_name => '{job_name}',
        use_current_session => FALSE
      );
    END;
    /
    """

    subprocess.run(
        ["sqlplus", "-s", "/ as sysdba"],
        input=sql,
        text=True,
        check=False
    )

