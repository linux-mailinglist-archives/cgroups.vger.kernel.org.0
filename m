Return-Path: <cgroups+bounces-11059-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 90EDCC00586
	for <lists+cgroups@lfdr.de>; Thu, 23 Oct 2025 11:51:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 17030188287A
	for <lists+cgroups@lfdr.de>; Thu, 23 Oct 2025 09:51:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B2682FDC29;
	Thu, 23 Oct 2025 09:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="azfDjNK/"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C94D30AAC4
	for <cgroups@vger.kernel.org>; Thu, 23 Oct 2025 09:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761213077; cv=none; b=SdMuuEJd7v1xdi8aiDU8YQVv5Mjc6T7TbOk5lqeizE7+MgXzFY4BkHifCQnSl47rEwOy1yDI3/os05FU+1XJ3A1M9k6KkMZWZ4fNHdtt9yqcpxkNpz9pBU8o7X1QZRmfnIg1NTRKkkDYun3URTVygBuAB/NrA6tt7byFiVAYmLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761213077; c=relaxed/simple;
	bh=CXbrKa1hvLe6JmQp/xqyfACy+pFVJ+FMVXMF2mo35cQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=q7Mhjgs/Nddadqg4jeezMpXzzBNvB3h4PXXPSOHnZpj+ZYKofMHrWyCrGax8etqNw9QBfy3WT+XivcMKXb667LlzTbnfJrhr7Z9rJAJpf2jyfq2i9QFGI9JrUsDoWlIhSsqqoTVD8JQ5c1FoTF1mf4byQWmHowL4WiBXntIQM+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=azfDjNK/; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-475c696ab72so4610255e9.1
        for <cgroups@vger.kernel.org>; Thu, 23 Oct 2025 02:51:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1761213071; x=1761817871; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kgI1/2/m5YMCpla75pJWeIqwruSPrdmkAcaa18QQU7s=;
        b=azfDjNK/z6WgPFbSKSvLCsjZR+98elUy0QAgwre/qAPRHy2YU4xVLiXjO6JJIr6n+5
         r+rRe1b6KUgbgsuZ/cBstY2phmt3R7y/1dCPg3Sfk6vpXsasqFukeEi+3sRjyB8IyCGE
         timVz95KscwhQCXKiXEzYOXF2f8NnMlz27ZkaBiXnkbwgArT3qs0d1/A1rgK6lltFXai
         jP09mPKRGDLrVAkGHIj3h9wvx0NW3XUOdqvNijOEYDmhuxvh+RkDmdCvg2bnY8G4z7gu
         pH4Ysh8X4gSVG9cwsHCoL51zYIyu8EnUbCsS/36luNxpXpKsdGSIsngsKefLFB+lKig2
         yqQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761213071; x=1761817871;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kgI1/2/m5YMCpla75pJWeIqwruSPrdmkAcaa18QQU7s=;
        b=caqeDDUrBGpnxfaz55KpDeGcRXApoqIoUM1wSZPUK0hfteoo9y2P0a9hnVdsNPE9AS
         8MMHskj/PpshNNI5msjRo/VnUe26paCxC4E8EXkBoi1bFiMj1FTmbf7gpf10wdmp9qSl
         v6lT5bqoOrPm/sgvFXkcc7O+p2peR22yoV07Os7f33syJmLsaK2lrOjjICKhjRbHgSfa
         v9A6guYPZNaHVCgL3xTXXAMdfutKkL1kCTPsDYvsL5LPzBrhXEyArwaCjFjT5nipG1Kg
         bZtXlhNzgk8lwotHAgYoT6z0VNKvwl1VR9kuZztPw9nSU/yTCqDBx7tEeKqDH/9naSvF
         KbBQ==
X-Forwarded-Encrypted: i=1; AJvYcCVz2dUNHKReAOp5MIUmDeTJbBGcoY4YbbiKAch4ZQHPtMFi3vUSUoq7RtGIHDyEo200W/qj7vF9@vger.kernel.org
X-Gm-Message-State: AOJu0YwrFEMCCiaB8RpXCbAG+q8mSdV4icbBI0km13UAhnvNikW6FCfj
	+PyN9oQ252Lmg2e50c2OpNVWncykID1H4hJZsqSXCdFFgI88xfoXp5NMhqOxjWLDI6sLO04rDp7
	XazGf/LG5Q4u1rppk2Ti3zsGqHCEpV+QwMegOW7Bb3g==
X-Gm-Gg: ASbGncuwNTcxbfN3KUjjVsrV/NCtUNcaNYmW+NPpFeZdKRwJyAS0K02g8jBH7J2Y88T
	UGj5oWxq/pReu1VvYh1kMxXjs1lvSoOjabD4vCE15ShNfgvglpwmmU2K/idaqsRFQMKC/RaRunW
	BhdK4yQrBio6RoEFGnCG+BATQkzO1/2a9Nmjga0UThQbxVrOeMdLRMkD0K2i6tNNBEPdpzzb4WR
	xBN3Qxn+Hyon15bAC+VyuRq4AVrqlUTAoztb+xHrHzfGBTeo5FyunPq4w==
X-Google-Smtp-Source: AGHT+IG7meu9BpxIPzPnU9U+2aAU60beBZJwxQU/bnKug2rbcmSKjhZT5wO4UhS1t/oHzSaXQuCYigZkfet12DdBuP0=
X-Received: by 2002:a05:600c:37c7:b0:46e:1fb7:a1b3 with SMTP id
 5b1f17b1804b1-4711790b56emr147936735e9.23.1761213071378; Thu, 23 Oct 2025
 02:51:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251022064601.15945-1-sebastian.chlad@suse.com>
 <20251022064601.15945-5-sebastian.chlad@suse.com> <d6594555-d257-4f5e-8495-d902151b166b@huaweicloud.com>
In-Reply-To: <d6594555-d257-4f5e-8495-d902151b166b@huaweicloud.com>
From: Sebastian Chlad <sebastian.chlad@suse.com>
Date: Thu, 23 Oct 2025 11:50:59 +0200
X-Gm-Features: AWmQ_bknX2i_NsEpNjWS_DyL8EQCoqCK7T1wIVOGqNBdAvNQ3gySV9fk-0wzX9A
Message-ID: <CAJR+Y9J1fPRACgt0sscrhDQjZ4XdKQGSnEdm01v4=4oTb68_0w@mail.gmail.com>
Subject: Re: [PATCH 4/5] selftests/cgroup: rename values_close_report() to report_metrics()
To: Chen Ridong <chenridong@huaweicloud.com>
Cc: Sebastian Chlad <sebastianchlad@gmail.com>, cgroups@vger.kernel.org, mkoutny@suse.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Oct 23, 2025 at 3:29=E2=80=AFAM Chen Ridong <chenridong@huaweicloud=
.com> wrote:
>
>
>
> On 2025/10/22 14:46, Sebastian Chlad wrote:
> > The function values_close_report() is being renamed for the sake of
> > clarity and consistency with its purpose - reporting detailed usage
> > metrics during cgroup tests. Since this is a reporting function which
> > is controlled by the metrics_mode env variable there is no more print
> > of the metrics in case the test fails and this env var isn't set.
> > All references in the cpu tests use use the new function name.
> >
> > Signed-off-by: Sebastian Chlad <sebastian.chlad@suse.com>
> > ---
> >  .../selftests/cgroup/lib/cgroup_util.c        | 15 ++++----
> >  .../cgroup/lib/include/cgroup_util.h          |  2 +-
> >  tools/testing/selftests/cgroup/test_cpu.c     | 38 +++++++++++++------
> >  3 files changed, 35 insertions(+), 20 deletions(-)
> >
> > diff --git a/tools/testing/selftests/cgroup/lib/cgroup_util.c b/tools/t=
esting/selftests/cgroup/lib/cgroup_util.c
> > index 9735df26b163..9414d522613d 100644
> > --- a/tools/testing/selftests/cgroup/lib/cgroup_util.c
> > +++ b/tools/testing/selftests/cgroup/lib/cgroup_util.c
> > @@ -22,13 +22,13 @@
> >
> >  bool cg_test_v1_named;
> >
> > -static bool metric_mode =3D false;
> > +static bool metrics_mode =3D false;
> >
> >  __attribute__((constructor))
> >  static void init_metric_mode(void)
> >  {
> >      char *env =3D getenv("CGROUP_TEST_METRICS");
> > -    metric_mode =3D (env && atoi(env));
> > +    metrics_mode =3D (env && atoi(env));
> >  }
> >
>
> Could you name it metrics_mode from the start? That way, we can avoid ren=
aming it later.
>
> >  /*
> > @@ -40,21 +40,20 @@ int check_tolerance(long a, long b, int err)
> >  }
> >
> >  /*
> > - * Checks if two given values differ by less than err% of their sum an=
d assert
> > - * with detailed debug info if not.
> > + * Report detailed metrics if metrics_mode is enabled.
> >   */
> > -int values_close_report(long a, long b, int err)
> > +int report_metrics(long a, long b, int err, const char *test_name)
> >  {
> >       long diff  =3D labs(a - b);
> >       long limit =3D (a + b) / 100 * err;
> >       double actual_err =3D (a + b) ? (100.0 * diff / (a + b)) : 0.0;
> >       int close =3D diff <=3D limit;
> >
> > -     if (metric_mode || !close)
> > +     if (metrics_mode)
> >               fprintf(stderr,
> > -                     "[METRICS] actual=3D%ld expected=3D%ld | diff=3D%=
ld | limit=3D%ld | "
> > +                     "[METRICS: %s] actual=3D%ld expected=3D%ld | diff=
=3D%ld | limit=3D%ld | "
> >                       "tolerance=3D%d%% | actual_error=3D%.2f%%\n",
> > -                     a, b, diff, limit, err, actual_err);
> > +                     test_name, a, b, diff, limit, err, actual_err);
> >
> >       return close;
> >  }
>
> Consider moving the metrics_mode check to the beginning of the function. =
If metrics are disabled,
> this avoids the unnecessary calculations.
>
> > diff --git a/tools/testing/selftests/cgroup/lib/include/cgroup_util.h b=
/tools/testing/selftests/cgroup/lib/include/cgroup_util.h
> > index 7b6c51f91937..3f5002810729 100644
> > --- a/tools/testing/selftests/cgroup/lib/include/cgroup_util.h
> > +++ b/tools/testing/selftests/cgroup/lib/include/cgroup_util.h
> > @@ -18,7 +18,7 @@
> >  #define CG_PATH_FORMAT (!cg_test_v1_named ? "0::%s" : (":name=3D" CG_N=
AMED_NAME ":%s"))
> >
> >  int check_tolerance(long a, long b, int err);
> > -int values_close_report(long a, long b, int err);
> > +int report_metrics(long a, long b, int err, const char *test_name);
> >
> >  extern ssize_t read_text(const char *path, char *buf, size_t max_len);
> >  extern ssize_t write_text(const char *path, char *buf, ssize_t len);
> > diff --git a/tools/testing/selftests/cgroup/test_cpu.c b/tools/testing/=
selftests/cgroup/test_cpu.c
> > index d54e2317efff..ff76eda99acd 100644
> > --- a/tools/testing/selftests/cgroup/test_cpu.c
> > +++ b/tools/testing/selftests/cgroup/test_cpu.c
> > @@ -187,6 +187,7 @@ static int test_cpucg_stats(const char *root)
> >       int ret =3D KSFT_FAIL;
> >       long usage_usec, user_usec, system_usec;
> >       long usage_seconds =3D 2;
> > +     int error_margin =3D 1;
> >       long expected_usage_usec =3D usage_seconds * USEC_PER_SEC;
> >       char *cpucg;
> >
> > @@ -219,7 +220,8 @@ static int test_cpucg_stats(const char *root)
> >       if (user_usec <=3D 0)
> >               goto cleanup;
> >
> > -     if (!values_close_report(usage_usec, expected_usage_usec, 1))
> > +     report_metrics(usage_usec, expected_usage_usec, error_margin, __f=
unc__);
> > +     if (!check_tolerance(usage_usec, expected_usage_usec, error_margi=
n))
> >               goto cleanup;
> >
> >       ret =3D KSFT_PASS;
> > @@ -241,6 +243,7 @@ static int test_cpucg_nice(const char *root)
> >       int status;
> >       long user_usec, nice_usec;
> >       long usage_seconds =3D 2;
> > +     int error_margin =3D 1;
> >       long expected_nice_usec =3D usage_seconds * USEC_PER_SEC;
> >       char *cpucg;
> >       pid_t pid;
> > @@ -291,7 +294,8 @@ static int test_cpucg_nice(const char *root)
> >
> >               user_usec =3D cg_read_key_long(cpucg, "cpu.stat", "user_u=
sec");
> >               nice_usec =3D cg_read_key_long(cpucg, "cpu.stat", "nice_u=
sec");
> > -             if (!values_close_report(nice_usec, expected_nice_usec, 1=
))
> > +             report_metrics(nice_usec, expected_nice_usec, error_margi=
n, __func__);
> > +             if (!check_tolerance(nice_usec, expected_nice_usec, error=
_margin))
> >                       goto cleanup;
> >
> >               ret =3D KSFT_PASS;
> > @@ -395,6 +399,7 @@ static pid_t weight_hog_all_cpus(const struct cpu_h=
ogger *child)
> >  static int
> >  overprovision_validate(const struct cpu_hogger *children, int num_chil=
dren)
> >  {
> > +     int error_margin =3D 35;
> >       int ret =3D KSFT_FAIL, i;
> >
> >       for (i =3D 0; i < num_children - 1; i++) {
> > @@ -404,7 +409,8 @@ overprovision_validate(const struct cpu_hogger *chi=
ldren, int num_children)
> >                       goto cleanup;
> >
> >               delta =3D children[i + 1].usage - children[i].usage;
> > -             if (!values_close_report(delta, children[0].usage, 35))
> > +             report_metrics(delta, children[0].usage, error_margin, __=
func__);
> > +             if (!check_tolerance(delta, children[0].usage, error_marg=
in))
> >                       goto cleanup;
> >       }
> >
> > @@ -441,10 +447,12 @@ static pid_t weight_hog_one_cpu(const struct cpu_=
hogger *child)
> >  static int
> >  underprovision_validate(const struct cpu_hogger *children, int num_chi=
ldren)
> >  {
> > +     int error_margin =3D 15;
> >       int ret =3D KSFT_FAIL, i;
> >
> >       for (i =3D 0; i < num_children - 1; i++) {
> > -             if (!values_close_report(children[i + 1].usage, children[=
0].usage, 15))
> > +             report_metrics(children[i + 1].usage, children[0].usage, =
error_margin, __func__);
> > +             if (!check_tolerance(children[i + 1].usage, children[0].u=
sage, error_margin))
> >                       goto cleanup;
> >       }
> >
> > @@ -573,16 +581,20 @@ run_cpucg_nested_weight_test(const char *root, bo=
ol overprovisioned)
> >
> >       nested_leaf_usage =3D leaf[1].usage + leaf[2].usage;
> >       if (overprovisioned) {
> > -             if (!values_close_report(leaf[0].usage, nested_leaf_usage=
, 15))
> > +             report_metrics(leaf[0].usage, nested_leaf_usage, 15, __fu=
nc__);
> > +             if (!check_tolerance(leaf[0].usage, nested_leaf_usage, 15=
))
> >                       goto cleanup;
> > -     } else if (!values_close_report(leaf[0].usage * 2, nested_leaf_us=
age, 15))
> > -             goto cleanup;
> > -
> > +     } else {
> > +             report_metrics(leaf[0].usage * 2, nested_leaf_usage, 15, =
__func__);
> > +             if (!check_tolerance(leaf[0].usage * 2, nested_leaf_usage=
, 15))
> > +                     goto cleanup;
> > +     }
> >
> >       child_usage =3D cg_read_key_long(child, "cpu.stat", "usage_usec")=
;
> >       if (child_usage <=3D 0)
> >               goto cleanup;
> > -     if (!values_close_report(child_usage, nested_leaf_usage, 1))
> > +     report_metrics(child_usage, nested_leaf_usage, 1, __func__);
> > +     if (!check_tolerance(child_usage, nested_leaf_usage, 1))
> >               goto cleanup;
> >
> >       ret =3D KSFT_PASS;
> > @@ -649,6 +661,7 @@ static int test_cpucg_max(const char *root)
> >       long quota_usec =3D 1000;
> >       long default_period_usec =3D 100000; /* cpu.max's default period =
*/
> >       long duration_seconds =3D 1;
> > +     int error_margin =3D 10;
> >
> >       long duration_usec =3D duration_seconds * USEC_PER_SEC;
> >       long usage_usec, n_periods, remainder_usec, expected_usage_usec;
> > @@ -691,7 +704,8 @@ static int test_cpucg_max(const char *root)
> >       expected_usage_usec
> >               =3D n_periods * quota_usec + MIN(remainder_usec, quota_us=
ec);
> >
> > -     if (!values_close_report(usage_usec, expected_usage_usec, 10))
> > +     report_metrics(usage_usec, expected_usage_usec, error_margin, __f=
unc__);
> > +     if (!check_tolerance(usage_usec, expected_usage_usec, error_margi=
n))
> >               goto cleanup;
> >
> >       ret =3D KSFT_PASS;
> > @@ -713,6 +727,7 @@ static int test_cpucg_max_nested(const char *root)
> >       long quota_usec =3D 1000;
> >       long default_period_usec =3D 100000; /* cpu.max's default period =
*/
> >       long duration_seconds =3D 1;
> > +     int error_margin =3D 10;
> >
> >       long duration_usec =3D duration_seconds * USEC_PER_SEC;
> >       long usage_usec, n_periods, remainder_usec, expected_usage_usec;
> > @@ -762,7 +777,8 @@ static int test_cpucg_max_nested(const char *root)
> >       expected_usage_usec
> >               =3D n_periods * quota_usec + MIN(remainder_usec, quota_us=
ec);
> >
> > -     if (!values_close_report(usage_usec, expected_usage_usec, 10))
> > +     report_metrics(usage_usec, expected_usage_usec, error_margin, __f=
unc__);
> > +     if (!check_tolerance(usage_usec, expected_usage_usec, error_margi=
n))
> >               goto cleanup;
> >
> >       ret =3D KSFT_PASS;
>
> Is this patch necessary?
>
> I'm concerned that users might not discover the environment variable to c=
ontrol output, I agree that
> detailed printouts on test failure are valuable. A better approach might =
be to print details only
> when a test fails, regardless of the environment variable.

Good point. I was considering this and my earlier patch focused on
that - provide the metrics in case the test fails hence I added
values_close_report().
I think this is a good approach that we could probably apply to more
tests, especially those that determine PASS/FAIL based on some
tolerance.

Adding a print on failure directly to values_close() doesn=E2=80=99t work a=
t
the moment, since test_memcontrol uses that function for intermediate
checks.

That said, I=E2=80=99d like to go a step further and enable a sort of
diagnostic mode for some tests, so we can see what metrics we get
regardless of whether
a PASS condition is met.
Since these tests also run in CI, it would be highly beneficial to
collect the metrics whenever desired - this would allow us
to observe trends over time and benchmark each kernel release against
previous ones. I imagine this would be also useful,
to any user who would like to compare a specific deployment/fork
against upstream vanilla benchmarks hence I also suggested publishing
sort of initial test results.

I think ideally we would be to have the value_close (renamed to
check_tolerance) returning the metrics in case of a fail; The only
caveat is  - as mentioned above -
that in some test_memcontrol cases, that function is used for
intermediate checks, which I=E2=80=99d need to handle carefully.
And we would still get the report_metrics() as an optional step to be
enabled using env var.

I'm happy to work on that but I wanted to get some initial feedback
and ideas to see if others find this useful.

Thanks again for your feedback.

Best Regards,
Sebastian

>
> --
> Best regards,
> Ridong
>

