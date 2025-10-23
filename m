Return-Path: <cgroups+bounces-11057-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F97BBFED96
	for <lists+cgroups@lfdr.de>; Thu, 23 Oct 2025 03:29:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E32CE3A6868
	for <lists+cgroups@lfdr.de>; Thu, 23 Oct 2025 01:29:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5357419E992;
	Thu, 23 Oct 2025 01:29:22 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from dggsgout12.his.huawei.com (dggsgout12.his.huawei.com [45.249.212.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF003EEC0
	for <cgroups@vger.kernel.org>; Thu, 23 Oct 2025 01:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761182962; cv=none; b=oPvDnXKv1BlyYm2Tkp2M1cNPk+MDisfWdDS+L/DYNT10GDuNFnasE7nb75I/LpB5p6J+mrrz4OPu7F7Co3RiEV7aCz+/6K6zfgqljh0h3LMrvajKSLHMfwumQ+DD5Tr8YKlmHEIsxWDfYInjH7sBsEbGIznzaKAuZA/ZcEol/40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761182962; c=relaxed/simple;
	bh=IXDj3RvrVj1WkLPcA27Y4M84yR5WAgZl4GC08sO28Wc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eGjUyh793IpAAdRg9AlnH2afu5mckZqw1TsorJvPQKVlXZjJt7I/A4iKtO+qoeoioo+0S9GZhXhXSEu5yUaeiX11j84tR3+wi7v9EnK31+injTjd7iozhQYRs34x97StS6ps9GiN+zeh4togtTxf2OCljG4POsdEXhwy3fr3G94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com; spf=pass smtp.mailfrom=huaweicloud.com; arc=none smtp.client-ip=45.249.212.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=huaweicloud.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huaweicloud.com
Received: from mail.maildlp.com (unknown [172.19.163.216])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4csT231z6BzKHMPM
	for <cgroups@vger.kernel.org>; Thu, 23 Oct 2025 09:28:27 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.75])
	by mail.maildlp.com (Postfix) with ESMTP id E5F191A111D
	for <cgroups@vger.kernel.org>; Thu, 23 Oct 2025 09:29:15 +0800 (CST)
Received: from [10.67.111.176] (unknown [10.67.111.176])
	by APP2 (Coremail) with SMTP id Syh0CgAXu0PqhPloVh8sBQ--.33475S2;
	Thu, 23 Oct 2025 09:29:15 +0800 (CST)
Message-ID: <d6594555-d257-4f5e-8495-d902151b166b@huaweicloud.com>
Date: Thu, 23 Oct 2025 09:29:14 +0800
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/5] selftests/cgroup: rename values_close_report() to
 report_metrics()
To: Sebastian Chlad <sebastianchlad@gmail.com>, cgroups@vger.kernel.org
Cc: mkoutny@suse.com, Sebastian Chlad <sebastian.chlad@suse.com>
References: <20251022064601.15945-1-sebastian.chlad@suse.com>
 <20251022064601.15945-5-sebastian.chlad@suse.com>
Content-Language: en-US
From: Chen Ridong <chenridong@huaweicloud.com>
In-Reply-To: <20251022064601.15945-5-sebastian.chlad@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CM-TRANSID:Syh0CgAXu0PqhPloVh8sBQ--.33475S2
X-Coremail-Antispam: 1UD129KBjvJXoWxKw15Gw1rGrW8Cr15AFW3trb_yoWfZr1xpa
	ykGryDtw48tFy3CF1SvFWq9F4kWrn8Jr17Jwn5JFyfuFn3XwnrXrWrKwn8Xr17urZYvrnx
	ZayUKas3ZrWUKaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUgvb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k2
	6cxKx2IYs7xG6rWj6s0DM7CIcVAFz4kK6r1j6r18M28lY4IEw2IIxxk0rwA2F7IY1VAKz4
	vEj48ve4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7Cj
	xVAFwI0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x
	0267AKxVW0oVCq3wAS0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG
	6I80ewAv7VC0I7IYx2IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFV
	Cjc4AY6r1j6r4UM4x0Y48IcVAKI48JMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY
	6r1j6r4UMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7xvwVAFwI0_JrI_JrWlx4CE17
	CEb7AF67AKxVWUAVWUtwCIc40Y0x0EwIxGrwCI42IY6xIIjxv20xvE14v26r1j6r1xMIIF
	0xvE2Ix0cI8IcVCY1x0267AKxVWUJVW8JwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIx
	AIcVC2z280aVAFwI0_Jr0_Gr1lIxAIcVC2z280aVCY1x0267AKxVWUJVW8JbIYCTnIWIev
	Ja73UjIFyTuYvjxUzsqWUUUUU
X-CM-SenderInfo: hfkh02xlgr0w46kxt4xhlfz01xgou0bp/



On 2025/10/22 14:46, Sebastian Chlad wrote:
> The function values_close_report() is being renamed for the sake of
> clarity and consistency with its purpose - reporting detailed usage
> metrics during cgroup tests. Since this is a reporting function which
> is controlled by the metrics_mode env variable there is no more print
> of the metrics in case the test fails and this env var isn't set.
> All references in the cpu tests use use the new function name.
> 
> Signed-off-by: Sebastian Chlad <sebastian.chlad@suse.com>
> ---
>  .../selftests/cgroup/lib/cgroup_util.c        | 15 ++++----
>  .../cgroup/lib/include/cgroup_util.h          |  2 +-
>  tools/testing/selftests/cgroup/test_cpu.c     | 38 +++++++++++++------
>  3 files changed, 35 insertions(+), 20 deletions(-)
> 
> diff --git a/tools/testing/selftests/cgroup/lib/cgroup_util.c b/tools/testing/selftests/cgroup/lib/cgroup_util.c
> index 9735df26b163..9414d522613d 100644
> --- a/tools/testing/selftests/cgroup/lib/cgroup_util.c
> +++ b/tools/testing/selftests/cgroup/lib/cgroup_util.c
> @@ -22,13 +22,13 @@
>  
>  bool cg_test_v1_named;
>  
> -static bool metric_mode = false;
> +static bool metrics_mode = false;
>  
>  __attribute__((constructor))
>  static void init_metric_mode(void)
>  {
>      char *env = getenv("CGROUP_TEST_METRICS");
> -    metric_mode = (env && atoi(env));
> +    metrics_mode = (env && atoi(env));
>  }
>  

Could you name it metrics_mode from the start? That way, we can avoid renaming it later.

>  /*
> @@ -40,21 +40,20 @@ int check_tolerance(long a, long b, int err)
>  }
>  
>  /*
> - * Checks if two given values differ by less than err% of their sum and assert
> - * with detailed debug info if not.
> + * Report detailed metrics if metrics_mode is enabled.
>   */
> -int values_close_report(long a, long b, int err)
> +int report_metrics(long a, long b, int err, const char *test_name)
>  {
>  	long diff  = labs(a - b);
>  	long limit = (a + b) / 100 * err;
>  	double actual_err = (a + b) ? (100.0 * diff / (a + b)) : 0.0;
>  	int close = diff <= limit;
>  
> -	if (metric_mode || !close)
> +	if (metrics_mode)
>  		fprintf(stderr,
> -			"[METRICS] actual=%ld expected=%ld | diff=%ld | limit=%ld | "
> +			"[METRICS: %s] actual=%ld expected=%ld | diff=%ld | limit=%ld | "
>  			"tolerance=%d%% | actual_error=%.2f%%\n",
> -			a, b, diff, limit, err, actual_err);
> +			test_name, a, b, diff, limit, err, actual_err);
>  
>  	return close;
>  }

Consider moving the metrics_mode check to the beginning of the function. If metrics are disabled,
this avoids the unnecessary calculations.

> diff --git a/tools/testing/selftests/cgroup/lib/include/cgroup_util.h b/tools/testing/selftests/cgroup/lib/include/cgroup_util.h
> index 7b6c51f91937..3f5002810729 100644
> --- a/tools/testing/selftests/cgroup/lib/include/cgroup_util.h
> +++ b/tools/testing/selftests/cgroup/lib/include/cgroup_util.h
> @@ -18,7 +18,7 @@
>  #define CG_PATH_FORMAT (!cg_test_v1_named ? "0::%s" : (":name=" CG_NAMED_NAME ":%s"))
>  
>  int check_tolerance(long a, long b, int err);
> -int values_close_report(long a, long b, int err);
> +int report_metrics(long a, long b, int err, const char *test_name);
>  
>  extern ssize_t read_text(const char *path, char *buf, size_t max_len);
>  extern ssize_t write_text(const char *path, char *buf, ssize_t len);
> diff --git a/tools/testing/selftests/cgroup/test_cpu.c b/tools/testing/selftests/cgroup/test_cpu.c
> index d54e2317efff..ff76eda99acd 100644
> --- a/tools/testing/selftests/cgroup/test_cpu.c
> +++ b/tools/testing/selftests/cgroup/test_cpu.c
> @@ -187,6 +187,7 @@ static int test_cpucg_stats(const char *root)
>  	int ret = KSFT_FAIL;
>  	long usage_usec, user_usec, system_usec;
>  	long usage_seconds = 2;
> +	int error_margin = 1;
>  	long expected_usage_usec = usage_seconds * USEC_PER_SEC;
>  	char *cpucg;
>  
> @@ -219,7 +220,8 @@ static int test_cpucg_stats(const char *root)
>  	if (user_usec <= 0)
>  		goto cleanup;
>  
> -	if (!values_close_report(usage_usec, expected_usage_usec, 1))
> +	report_metrics(usage_usec, expected_usage_usec, error_margin, __func__);
> +	if (!check_tolerance(usage_usec, expected_usage_usec, error_margin))
>  		goto cleanup;
>  
>  	ret = KSFT_PASS;
> @@ -241,6 +243,7 @@ static int test_cpucg_nice(const char *root)
>  	int status;
>  	long user_usec, nice_usec;
>  	long usage_seconds = 2;
> +	int error_margin = 1;
>  	long expected_nice_usec = usage_seconds * USEC_PER_SEC;
>  	char *cpucg;
>  	pid_t pid;
> @@ -291,7 +294,8 @@ static int test_cpucg_nice(const char *root)
>  
>  		user_usec = cg_read_key_long(cpucg, "cpu.stat", "user_usec");
>  		nice_usec = cg_read_key_long(cpucg, "cpu.stat", "nice_usec");
> -		if (!values_close_report(nice_usec, expected_nice_usec, 1))
> +		report_metrics(nice_usec, expected_nice_usec, error_margin, __func__);
> +		if (!check_tolerance(nice_usec, expected_nice_usec, error_margin))
>  			goto cleanup;
>  
>  		ret = KSFT_PASS;
> @@ -395,6 +399,7 @@ static pid_t weight_hog_all_cpus(const struct cpu_hogger *child)
>  static int
>  overprovision_validate(const struct cpu_hogger *children, int num_children)
>  {
> +	int error_margin = 35;
>  	int ret = KSFT_FAIL, i;
>  
>  	for (i = 0; i < num_children - 1; i++) {
> @@ -404,7 +409,8 @@ overprovision_validate(const struct cpu_hogger *children, int num_children)
>  			goto cleanup;
>  
>  		delta = children[i + 1].usage - children[i].usage;
> -		if (!values_close_report(delta, children[0].usage, 35))
> +		report_metrics(delta, children[0].usage, error_margin, __func__);
> +		if (!check_tolerance(delta, children[0].usage, error_margin))
>  			goto cleanup;
>  	}
>  
> @@ -441,10 +447,12 @@ static pid_t weight_hog_one_cpu(const struct cpu_hogger *child)
>  static int
>  underprovision_validate(const struct cpu_hogger *children, int num_children)
>  {
> +	int error_margin = 15;
>  	int ret = KSFT_FAIL, i;
>  
>  	for (i = 0; i < num_children - 1; i++) {
> -		if (!values_close_report(children[i + 1].usage, children[0].usage, 15))
> +		report_metrics(children[i + 1].usage, children[0].usage, error_margin, __func__);
> +		if (!check_tolerance(children[i + 1].usage, children[0].usage, error_margin))
>  			goto cleanup;
>  	}
>  
> @@ -573,16 +581,20 @@ run_cpucg_nested_weight_test(const char *root, bool overprovisioned)
>  
>  	nested_leaf_usage = leaf[1].usage + leaf[2].usage;
>  	if (overprovisioned) {
> -		if (!values_close_report(leaf[0].usage, nested_leaf_usage, 15))
> +		report_metrics(leaf[0].usage, nested_leaf_usage, 15, __func__);
> +		if (!check_tolerance(leaf[0].usage, nested_leaf_usage, 15))
>  			goto cleanup;
> -	} else if (!values_close_report(leaf[0].usage * 2, nested_leaf_usage, 15))
> -		goto cleanup;
> -
> +	} else {
> +		report_metrics(leaf[0].usage * 2, nested_leaf_usage, 15, __func__);
> +		if (!check_tolerance(leaf[0].usage * 2, nested_leaf_usage, 15))
> +			goto cleanup;
> +	}
>  
>  	child_usage = cg_read_key_long(child, "cpu.stat", "usage_usec");
>  	if (child_usage <= 0)
>  		goto cleanup;
> -	if (!values_close_report(child_usage, nested_leaf_usage, 1))
> +	report_metrics(child_usage, nested_leaf_usage, 1, __func__);
> +	if (!check_tolerance(child_usage, nested_leaf_usage, 1))
>  		goto cleanup;
>  
>  	ret = KSFT_PASS;
> @@ -649,6 +661,7 @@ static int test_cpucg_max(const char *root)
>  	long quota_usec = 1000;
>  	long default_period_usec = 100000; /* cpu.max's default period */
>  	long duration_seconds = 1;
> +	int error_margin = 10;
>  
>  	long duration_usec = duration_seconds * USEC_PER_SEC;
>  	long usage_usec, n_periods, remainder_usec, expected_usage_usec;
> @@ -691,7 +704,8 @@ static int test_cpucg_max(const char *root)
>  	expected_usage_usec
>  		= n_periods * quota_usec + MIN(remainder_usec, quota_usec);
>  
> -	if (!values_close_report(usage_usec, expected_usage_usec, 10))
> +	report_metrics(usage_usec, expected_usage_usec, error_margin, __func__);
> +	if (!check_tolerance(usage_usec, expected_usage_usec, error_margin))
>  		goto cleanup;
>  
>  	ret = KSFT_PASS;
> @@ -713,6 +727,7 @@ static int test_cpucg_max_nested(const char *root)
>  	long quota_usec = 1000;
>  	long default_period_usec = 100000; /* cpu.max's default period */
>  	long duration_seconds = 1;
> +	int error_margin = 10;
>  
>  	long duration_usec = duration_seconds * USEC_PER_SEC;
>  	long usage_usec, n_periods, remainder_usec, expected_usage_usec;
> @@ -762,7 +777,8 @@ static int test_cpucg_max_nested(const char *root)
>  	expected_usage_usec
>  		= n_periods * quota_usec + MIN(remainder_usec, quota_usec);
>  
> -	if (!values_close_report(usage_usec, expected_usage_usec, 10))
> +	report_metrics(usage_usec, expected_usage_usec, error_margin, __func__);
> +	if (!check_tolerance(usage_usec, expected_usage_usec, error_margin))
>  		goto cleanup;
>  
>  	ret = KSFT_PASS;

Is this patch necessary?

I'm concerned that users might not discover the environment variable to control output, I agree that
detailed printouts on test failure are valuable. A better approach might be to print details only
when a test fails, regardless of the environment variable.

-- 
Best regards,
Ridong


