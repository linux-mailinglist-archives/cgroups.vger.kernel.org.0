Return-Path: <cgroups+bounces-17200-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id S1TNLdbhOmrUJwgAu9opvQ
	(envelope-from <cgroups+bounces-17200-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 23 Jun 2026 21:43:18 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 149AB6B9C18
	for <lists+cgroups@lfdr.de>; Tue, 23 Jun 2026 21:43:18 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=T3Rjn1TY;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17200-lists+cgroups=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="cgroups+bounces-17200-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F01493046347
	for <lists+cgroups@lfdr.de>; Tue, 23 Jun 2026 19:42:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF69C365A00;
	Tue, 23 Jun 2026 19:42:56 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D36F3932DC
	for <cgroups@vger.kernel.org>; Tue, 23 Jun 2026 19:42:55 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782243776; cv=none; b=J5GaO01BQKkFKSFzP0k2eD608Ks06iuCmEHKL6kMWtKXoYD56eDct5FuWjlBR40WfAO7XaJN4+FOiU5vU1nKdU6fVzSeBCTnvWkDlMy/5O2u5AhN509DtxoSjy00yYyseolLJEL8eSMKb7aRStJbV+OpPvNiQdnYW8eNJTKRyBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782243776; c=relaxed/simple;
	bh=Ww9gRwwW5OyRm9/FcGjCmZ/h7+HlYlxCRlQnZQEWa0I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SP/mCreH1IF7u3aFYlwu7Qo2zPNNUFJZLhLDn8YuBViNPtubmIbmWazfvMaeYbcQzpfSYaGgaDdsC6sk37GtYKzBCQSObJ9ksk1wPmqXMSpw9+c4sNHAUyt5wVUPA+sJ786WXUvVYNp1RjmjFX+R66siCUQLwm6l8Za6wNEd1to=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=T3Rjn1TY; arc=none smtp.client-ip=170.10.133.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782243774;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kygwExbrozp64++sRcXVlZDrcpqusoOkCOx9RMb2NQE=;
	b=T3Rjn1TYhD2ptQ8OsEMnAU6ltVsn0mQZvdBK0XX3vsUblrI7f6uDaqWb1EGfmPdsaCBO0x
	qS67KhucKNetPnnuX+a9UCMTVKt+jVfr2kiXClVXkh+GG9l9z4hX480/SH4kjtqPJ8qG2x
	w0so4YMvuo0suDV2kzBhxKanfmy6T0g=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-646-pEOWMlLbMK26X_fS5f1ljA-1; Tue,
 23 Jun 2026 15:42:49 -0400
X-MC-Unique: pEOWMlLbMK26X_fS5f1ljA-1
X-Mimecast-MFC-AGG-ID: pEOWMlLbMK26X_fS5f1ljA_1782243768
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id ADB3518052C9;
	Tue, 23 Jun 2026 19:42:47 +0000 (UTC)
Received: from oak (unknown [10.22.65.142])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A7A6C1800591;
	Tue, 23 Jun 2026 19:42:45 +0000 (UTC)
Date: Tue, 23 Jun 2026 15:42:39 -0400
From: Joe Simmons-Talbott <josimmon@redhat.com>
To: Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
Cc: Joe Simmons-Talbott <joest@redhat.com>, Tejun Heo <tj@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>, Shuah Khan <shuah@kernel.org>,
	cgroups@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Sebastian Chlad <sebastian.chlad@suse.com>
Subject: Re: [PATCH v2] selftests/cgroup: Adjust cpu.max quota based on HZ
Message-ID: <20260623194239.GA899029@oak>
References: <20260622194305.601392-1-joest@redhat.com>
 <ajqBjmJ-VT3UDPMr@localhost.localdomain>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ajqBjmJ-VT3UDPMr@localhost.localdomain>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-17200-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[josimmon@redhat.com,cgroups@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:mkoutny@suse.com,m:joest@redhat.com,m:tj@kernel.org,m:hannes@cmpxchg.org,m:shuah@kernel.org,m:cgroups@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:sebastian.chlad@suse.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[josimmon@redhat.com,cgroups@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	DBL_BLOCKED_OPENRESOLVER(0.00)[oak:mid,vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 149AB6B9C18

On Tue, Jun 23, 2026 at 03:52:30PM +0200, Michal Koutný wrote:
> On Mon, Jun 22, 2026 at 03:43:04PM -0400, Joe Simmons-Talbott <joest@redhat.com> wrote:
> > +static long
> > +_get_config_hz(void)
> > +{
> > +	long hz = -1;
> > +	FILE *f;
> > +	char cmd[256] = "zcat /proc/config.gz 2>/dev/null | grep '^CONFIG_HZ='";
> > +
> > +	f = popen(cmd, "r");
> > +
> > +	if (!f)
> > +		goto out;
> > +
> > +	fscanf(f, "CONFIG_HZ=%ld", &hz);
> > +
> > +out:
> > +	pclose(f);
> > +	return hz;
> > +}
> 
> I like that you voiced this dependency on CONFIG_HZ and also that
> _SC_CLK_TCK is useless in this regards.
> (I see that BPF selftests have similar infra for this.)
> 
> 
> > +
> >  /*
> >   * This test creates a cgroup with some maximum value within a period, and
> >   * verifies that a process in the cgroup is not overscheduled.
> > @@ -646,7 +669,8 @@ test_cpucg_nested_weight_underprovisioned(const char *root)
> >  static int test_cpucg_max(const char *root)
> >  {
> >  	int ret = KSFT_FAIL;
> > -	long quota_usec = 1000;
> > +	long hz = _get_config_hz();
> > +	long quota_usec;
> >  	long default_period_usec = 100000; /* cpu.max's default period */
> >  	long duration_seconds = 1;
> 
> I would not bend the tested value but it's expectation (so that
> approximately same quantity is tested acroos configs).
> 
> I reckon the problem might be tasks that overrun the quota due to long
> tick, fortunately, we can assume this is compensated over multiple
> periods, so _on average_ quota should be honored (more) precisely.
> But the test duration may be not well aligned with all the compensation
> periods, to that must be accounted for in the expectation.
> 
> When I write it all down, I get this:
> 
> --- a/tools/testing/selftests/cgroup/test_cpu.c
> +++ b/tools/testing/selftests/cgroup/test_cpu.c
> @@ -651,7 +651,9 @@ static int test_cpucg_max(const char *root)
>         long duration_seconds = 1;
> 
>         long duration_usec = duration_seconds * USEC_PER_SEC;
> -       long usage_usec, n_periods, remainder_usec, expected_usage_usec;
> +       long usage_usec, expected_usage_usec;
> +       long n_periods, spread_periods, unaligned;
> +       long tick_usec, low_usage, high_usage;
>         char *cpucg;
>         char quota_buf[32];
> 
> @@ -687,9 +689,16 @@ static int test_cpucg_max(const char *root)
>          * the cpu hog is set to run as per wall-clock time
>          */
>         n_periods = duration_usec / default_period_usec;
> -       remainder_usec = duration_usec - n_periods * default_period_usec;
> -       expected_usage_usec
> -               = n_periods * quota_usec + MIN(remainder_usec, quota_usec);
> +       tick_usec = USEC_PER_SEC / hz;
> +       /* Up to tick_usec (over)run is compensated over multiple periods */
> +       spread_periods = MAX(1, tick_usec / quota_usec);
> +       low_usage = n_periods / spread_periods;
> +       high_usage = (n_periods + spread_periods - 1) / spread_periods;
> +       unaligned = n_periods % spread_periods;
> +
> +       expected_usage_usec = quota_usec * (
> +               unaligned * high_usage +
> +               (spread_periods - unaligned) * low_usage);
> 
>         if (!values_close_report(usage_usec, expected_usage_usec, 10))
>                 goto cleanup;
> 
> 
> (I neglected (and dropped) remainder_usec because it is zero with
> default values)
> 
> However, not all preemptions are tick-based, so there'd be noise 
> and one has to tune the values_clone_report(,,err) anyway.
> 
> Then to reduce noise, the simpler solution is to let the test run
> longer
> 
> duration_usec = duration_seconds * USEC_PER_SEC * 1000 / hz;
> 
> (where 1000 is the CONFIG_HZ=1000 where the test runs sufficiently [1] well.)
> 
> Joe, how do to the two variants above (unalignment account and prolonged
> duration) affect test_cpu behavior on your setup?

Hi Michal,

Thank you for your review.

I tried both approaches, unalignment account and prolonged duration, and
both allowed me to run 10 iterations of the test_cpu tests without any
failures. I will use the simpler prolonged duration approach in v3 if
that is okay.

Thanks,
Joe

> 
> (I'm personally wondering what is bigger quantity: systemic error due to
> HZ quantization or random (SMP) error.)
> 
> Thanks,
> Michal
> 
> [1] Even there one runs into noise depending on nr_cpus, thus even that
>     fixed err=10 is not ideal.



