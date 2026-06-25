Return-Path: <cgroups+bounces-17298-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id kUccNeKPPWpo4AgAu9opvQ
	(envelope-from <cgroups+bounces-17298-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Thu, 25 Jun 2026 22:30:26 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EBA86C8827
	for <lists+cgroups@lfdr.de>; Thu, 25 Jun 2026 22:30:26 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=GCYc1B76;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17298-lists+cgroups=lfdr.de@vger.kernel.org" designates 172.232.135.74 as permitted sender) smtp.mailfrom="cgroups+bounces-17298-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D08A6304592E
	for <lists+cgroups@lfdr.de>; Thu, 25 Jun 2026 20:30:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B29663655FA;
	Thu, 25 Jun 2026 20:30:24 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B8C330C168
	for <cgroups@vger.kernel.org>; Thu, 25 Jun 2026 20:30:22 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782419424; cv=none; b=kLE83PEp/pH616L3JBAbaaj8EZbp1EjMH9ayyRAFTQTOaj32oX/IELtMbLiP4GeNZhXzaDSEN06miSDeIC9kQFpFFINJ5XW806WEpNIW36iQwTIcLu1+6g9z8ZoWsp0unbjV22jr5keO9TbjOgYlPqeGP2C7q+kGMF0oYowbY+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782419424; c=relaxed/simple;
	bh=89Ml65G1QUio1WavQ1QChKfTQDiRfejS50lqj2GD54k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Dxr3iYOoAAls3KhMIt+6xsZhHaUfU9cg+FTvqHf6V0upfjgAFrQ9pNwBzmSHhMdGwsyIAex3fB3yfQmVQSvJBG1HT3dbgbi5kxK4RK5rmRgjN/V+z9rOpmqLdezSgggcesyQUHq20g0mDuu7EXW5chMRkE8oqDcc5LaHmdG4+yA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GCYc1B76; arc=none smtp.client-ip=170.10.133.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782419422;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Jt/gWKq5ucqcH9gYrbFZIXJYR83Qr4GMmWHDpJfsng0=;
	b=GCYc1B76sBn2cxQAxcpdJqznQEUwa5G8FrWujc+vpEGQKPNSlxipaNZ76aLHVBaYEoqMyN
	oF6HziIoTiCtrMqsz+3YX0sy5c7B5k3icph5qRhP5hIxBGQ9h8O4l0cEkcfpaJCNQ5QULM
	s3PNj9jiS1rbluOzHTuaE+IpeXIwoDE=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-472-V6rZ5yUgOfugMfsdB67moQ-1; Thu,
 25 Jun 2026 16:30:17 -0400
X-MC-Unique: V6rZ5yUgOfugMfsdB67moQ-1
X-Mimecast-MFC-AGG-ID: V6rZ5yUgOfugMfsdB67moQ_1782419416
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 22CF019775E0;
	Thu, 25 Jun 2026 20:30:15 +0000 (UTC)
Received: from oak (unknown [10.22.88.172])
	by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2B807414;
	Thu, 25 Jun 2026 20:30:11 +0000 (UTC)
Date: Thu, 25 Jun 2026 16:30:06 -0400
From: Joe Simmons-Talbott <josimmon@redhat.com>
To: Joe Simmons-Talbott <joest@redhat.com>
Cc: Tejun Heo <tj@kernel.org>, Johannes Weiner <hannes@cmpxchg.org>,
	Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
	Shuah Khan <shuah@kernel.org>, Nhat Pham <nphamcs@gmail.com>,
	Guopeng Zhang <zhangguopeng@kylinos.cn>,
	Shakeel Butt <shakeel.butt@linux.dev>, Li Wang <li.wang@linux.dev>,
	Sebastian Chlad <sebastianchlad@gmail.com>, cgroups@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
	cui.tao@linux.dev
Subject: Re: [PATCH v4] selftests/cgroup: Adjust cpu test duration based on HZ
Message-ID: <20260625203006.GB19617@oak>
References: <20260625195415.1102409-1-joest@redhat.com>
 <CAAQBMsPXjFGbQFa3ufvDDHxjgdj+5_kD0PLGD7vn19YNsEV_Kg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAAQBMsPXjFGbQFa3ufvDDHxjgdj+5_kD0PLGD7vn19YNsEV_Kg@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-17298-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[josimmon@redhat.com,cgroups@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:joest@redhat.com,m:tj@kernel.org,m:hannes@cmpxchg.org,m:mkoutny@suse.com,m:shuah@kernel.org,m:nphamcs@gmail.com,m:zhangguopeng@kylinos.cn,m:shakeel.butt@linux.dev,m:li.wang@linux.dev,m:sebastianchlad@gmail.com,m:cgroups@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:cui.tao@linux.dev,s:lists@lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,cmpxchg.org,suse.com,gmail.com,kylinos.cn,linux.dev,vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[josimmon@redhat.com,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[redhat.com:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6EBA86C8827

On Thu, Jun 25, 2026 at 04:20:25PM -0400, Joe Simmons-Talbott wrote:
> On Thu, Jun 25, 2026 at 3:54 PM Joe Simmons-Talbott <joest@redhat.com> wrote:
> >
> 
> +mailing lists
> +Tao Cui

I messed this up.  Please ignore this patch.  I will resend.

Thanks,
Joe
> 
> 
> 
> > For lower HZ values a quota of 1000us is much lower than the amount
> > of microseconds per tick which makes the tests test_cpucg_max and
> > test_cpugc_max_nested fail. Increase the test duration to accommodate
> > for lower HZ values.
> >
> > Link: https://lore.kernel.org/lkml/20260624160358.430354-1-joest@redhat.com/
> > Signed-off-by: Joe Simmons-Talbott <joest@redhat.com>
> > ---
> > v3 -> v4:
> > - Use usec for adjusting test duration for better accuracy.
> > - Remove underscore from static function
> > - Use 1000 as the fallback value for hz since it's the default.
> >
> > v2 -> v3:
> > - Instead of changing cpu.max quota extend the test duration based on
> >   the HZ value.
> > - don't call pclose() if popen() fails.
> > - check return value of fscanf().
> >
> > v1 -> v2:
> > - Try checking /proc/config.gz to get the actual kernel HZ value and
> >   fallback to 1000 if the value cannot be determined.
> >
> >  .../cgroup/lib/include/cgroup_util.h          |  1 +
> >  tools/testing/selftests/cgroup/test_cpu.c     | 47 ++++++++++++++++---
> >  2 files changed, 42 insertions(+), 6 deletions(-)
> >
> > diff --git a/tools/testing/selftests/cgroup/lib/include/cgroup_util.h b/tools/testing/selftests/cgroup/lib/include/cgroup_util.h
> > index febc1723d090..8ebb2b4d4ec0 100644
> > --- a/tools/testing/selftests/cgroup/lib/include/cgroup_util.h
> > +++ b/tools/testing/selftests/cgroup/lib/include/cgroup_util.h
> > @@ -8,6 +8,7 @@
> >
> >  #define MB(x) (x << 20)
> >
> > +#define NSEC_PER_USEC  1000L
> >  #define USEC_PER_SEC   1000000L
> >  #define NSEC_PER_SEC   1000000000L
> >
> > diff --git a/tools/testing/selftests/cgroup/test_cpu.c b/tools/testing/selftests/cgroup/test_cpu.c
> > index 7a40d76b9548..1f280c1db68a 100644
> > --- a/tools/testing/selftests/cgroup/test_cpu.c
> > +++ b/tools/testing/selftests/cgroup/test_cpu.c
> > @@ -639,6 +639,31 @@ test_cpucg_nested_weight_underprovisioned(const char *root)
> >         return run_cpucg_nested_weight_test(root, false);
> >  }
> >
> > +/*
> > + * Best effort attempt to get the kernel's HZ value from the config.
> > + * Return the HZ value if found otherwise return 1000 (the default) to
> > + * indicate failure.
> > + */
> > +static long
> > +get_config_hz(void)
> > +{
> > +       long hz = 1000;
> > +       FILE *f;
> > +       char cmd[256] = "zcat /proc/config.gz 2>/dev/null | grep '^CONFIG_HZ='";
> > +
> > +       f = popen(cmd, "r");
> > +
> > +       if (!f)
> > +               return hz;
> > +
> > +       if (fscanf(f, "CONFIG_HZ=%ld", &hz) == EOF)
> > +               goto out;
> > +
> > +out:
> > +       pclose(f);
> > +       return hz;
> > +}
> > +
> >  /*
> >   * This test creates a cgroup with some maximum value within a period, and
> >   * verifies that a process in the cgroup is not overscheduled.
> > @@ -646,15 +671,20 @@ test_cpucg_nested_weight_underprovisioned(const char *root)
> >  static int test_cpucg_max(const char *root)
> >  {
> >         int ret = KSFT_FAIL;
> > +       long hz = get_config_hz();
> >         long quota_usec = 1000;
> >         long default_period_usec = 100000; /* cpu.max's default period */
> >         long duration_seconds = 1;
> >
> > -       long duration_usec = duration_seconds * USEC_PER_SEC;
> > +       long duration_usec, duration_sec, duration_nsec;
> >         long usage_usec, n_periods, remainder_usec, expected_usage_usec;
> >         char *cpucg;
> >         char quota_buf[32];
> >
> > +       duration_usec = duration_seconds * USEC_PER_SEC * 1000 / hz;
> > +       duration_sec = duration_usec / USEC_PER_SEC;
> > +       duration_nsec = duration_usec % USEC_PER_SEC * NSEC_PER_USEC;
> > +
> >         snprintf(quota_buf, sizeof(quota_buf), "%ld", quota_usec);
> >
> >         cpucg = cg_name(root, "cpucg_test");
> > @@ -670,8 +700,8 @@ static int test_cpucg_max(const char *root)
> >         struct cpu_hog_func_param param = {
> >                 .nprocs = 1,
> >                 .ts = {
> > -                       .tv_sec = duration_seconds,
> > -                       .tv_nsec = 0,
> > +                       .tv_sec = duration_sec,
> > +                       .tv_nsec = duration_nsec,
> >                 },
> >                 .clock_type = CPU_HOG_CLOCK_WALL,
> >         };
> > @@ -710,15 +740,20 @@ static int test_cpucg_max(const char *root)
> >  static int test_cpucg_max_nested(const char *root)
> >  {
> >         int ret = KSFT_FAIL;
> > +       long hz = get_config_hz();
> >         long quota_usec = 1000;
> >         long default_period_usec = 100000; /* cpu.max's default period */
> >         long duration_seconds = 1;
> >
> > -       long duration_usec = duration_seconds * USEC_PER_SEC;
> > +       long duration_usec, duration_sec, duration_nsec;
> >         long usage_usec, n_periods, remainder_usec, expected_usage_usec;
> >         char *parent, *child;
> >         char quota_buf[32];
> >
> > +       duration_usec = duration_seconds * USEC_PER_SEC * 1000 / hz;
> > +       duration_sec = duration_usec / USEC_PER_SEC;
> > +       duration_nsec = duration_usec % USEC_PER_SEC * NSEC_PER_USEC;
> > +
> >         snprintf(quota_buf, sizeof(quota_buf), "%ld", quota_usec);
> >
> >         parent = cg_name(root, "cpucg_parent");
> > @@ -741,8 +776,8 @@ static int test_cpucg_max_nested(const char *root)
> >         struct cpu_hog_func_param param = {
> >                 .nprocs = 1,
> >                 .ts = {
> > -                       .tv_sec = duration_seconds,
> > -                       .tv_nsec = 0,
> > +                       .tv_sec = duration_sec,
> > +                       .tv_nsec = duration_nsec,
> >                 },
> >                 .clock_type = CPU_HOG_CLOCK_WALL,
> >         };
> > --
> > 2.54.0
> >


