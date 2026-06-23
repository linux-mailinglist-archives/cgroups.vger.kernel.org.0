Return-Path: <cgroups+bounces-17184-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id MTJzEGZzOmpc9QcAu9opvQ
	(envelope-from <cgroups+bounces-17184-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 23 Jun 2026 13:52:06 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A38F66B6E25
	for <lists+cgroups@lfdr.de>; Tue, 23 Jun 2026 13:52:05 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=LPkbbK+7;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17184-lists+cgroups=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="cgroups+bounces-17184-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 96A0C3051D0A
	for <lists+cgroups@lfdr.de>; Tue, 23 Jun 2026 11:52:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2975F3D523F;
	Tue, 23 Jun 2026 11:52:02 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D8033D413F
	for <cgroups@vger.kernel.org>; Tue, 23 Jun 2026 11:52:00 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782215521; cv=none; b=ACykrvtf5I1JEYeuXbtffzvnYTK27QG0bUUsx6bLvx0T29g9sBZl3HIW1ZQ0NUYGJ0zkupubowfKx+vBveEFw13NFLCJmJmU09K/1w4zKPtKIurmTISWGqCq9h0ykETaHqAp5gPuoXGib8j+nAT0TciBva2HewGB72ZApGTDePU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782215521; c=relaxed/simple;
	bh=/l47Kc9yJkx+XNz925xiZzIZRoSo2GKP0MroQbjp7kQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zze60ycdMzZRTy4QzkIAel4A8Je0WTpejI8PPKD/B8IGE6e82/foj+rEZY2VhZU9i/V+n6Gir7HcIPzgxjaerJUpJp975wJX9EU/KRYFKw6wQfgJikFKV65X4UZDpq81R3tbfcsZzKpZ1i7sf6Qpo5N86b/dcGGgrLsbYT0VGa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=LPkbbK+7; arc=none smtp.client-ip=170.10.133.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782215519;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=S74gSn64dmM2ax5iC5oLh+bId+plYMetRVPgRAIEZk0=;
	b=LPkbbK+71KCmFn2peVXSI2bH8j3tTdQFJoHmOdAtuzMDW2ponj4g8IQEP09hWWIA9No3f3
	PzFZDaUNly/B5k7EGaVFnK94A8uqY5qOs6rcM4NP6Bi8tiKe/LAiVHbm6UWDglKe8Wu2sw
	vzklx1+bziE3m9BsvMzo/TycH9pRQ30=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-542-SM2MpXe8Pie_BkmvQbQ-aQ-1; Tue,
 23 Jun 2026 07:51:56 -0400
X-MC-Unique: SM2MpXe8Pie_BkmvQbQ-aQ-1
X-Mimecast-MFC-AGG-ID: SM2MpXe8Pie_BkmvQbQ-aQ_1782215515
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 66B951955F44;
	Tue, 23 Jun 2026 11:51:54 +0000 (UTC)
Received: from oak (unknown [10.22.80.162])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id A820A1956052;
	Tue, 23 Jun 2026 11:51:52 +0000 (UTC)
Date: Tue, 23 Jun 2026 07:51:33 -0400
From: Joe Simmons-Talbott <josimmon@redhat.com>
To: Tao Cui <cui.tao@linux.dev>
Cc: Joe Simmons-Talbott <joest@redhat.com>, Tejun Heo <tj@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
	Shuah Khan <shuah@kernel.org>, cgroups@vger.kernel.org,
	linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] selftests/cgroup: Adjust cpu.max quota based on HZ
Message-ID: <20260623115110.GA8885@oak>
References: <20260622194305.601392-1-joest@redhat.com>
 <d8bdf9ef-a393-4734-8639-308ac3eaa05c@linux.dev>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d8bdf9ef-a393-4734-8639-308ac3eaa05c@linux.dev>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-17184-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[josimmon@redhat.com,cgroups@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:cui.tao@linux.dev,m:joest@redhat.com,m:tj@kernel.org,m:hannes@cmpxchg.org,m:mkoutny@suse.com,m:shuah@kernel.org,m:cgroups@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: A38F66B6E25

On Tue, Jun 23, 2026 at 01:32:08PM +0800, Tao Cui wrote:
> 
> Hi Joe,
> 
> One comment on the fallback:
> 
>   quota_usec = hz != -1 ? USEC_PER_SEC / hz : 1000;
> 
> When HZ can't be determined (no CONFIG_IKCONFIG_PROC, or zcat missing),
> the fallback to 1000 is the exact value that fails at low HZ — so this
> doesn't actually fix such kernels. A larger fallback (e.g. 10000, the
> HZ=100 equivalent) would make the tests robust regardless of whether the
> config is exposed.

Hi Tao Cui,

Thank you for your review.

I am happy to use 10000 as the fallback value.  I will address this as
well as the sashiko comments in v3.

Thanks,
Joe
> 
> 在 2026/6/23 03:43, Joe Simmons-Talbott 写道:
> > For lower HZ values a quota of 1000us is much lower than the amount
> > of microseconds per tick which makes the tests test_cpucg_max and
> > test_cpugc_max_nested fail. Use the amount of microseconds per tick
> > as the quota value.
> > 
> > Signed-off-by: Joe Simmons-Talbott <joest@redhat.com>
> > ---
> > changes since v1:
> > - Try checking /proc/config.gz to get the actual kernel HZ value and
> >   fallback to 1000 if the value cannot be determined.
> > 
> >  tools/testing/selftests/cgroup/test_cpu.c | 33 +++++++++++++++++++++--
> >  1 file changed, 31 insertions(+), 2 deletions(-)
> > 
> > diff --git a/tools/testing/selftests/cgroup/test_cpu.c b/tools/testing/selftests/cgroup/test_cpu.c
> > index 7a40d76b9548..65e09555309f 100644
> > --- a/tools/testing/selftests/cgroup/test_cpu.c
> > +++ b/tools/testing/selftests/cgroup/test_cpu.c
> > @@ -639,6 +639,29 @@ test_cpucg_nested_weight_underprovisioned(const char *root)
> >  	return run_cpucg_nested_weight_test(root, false);
> >  }
> >  
> > +/*
> > + * Best effort attempt to get the kernel's HZ value from the config.
> > + * Return the HZ value if found otherwise return -1 to indicate failure.
> > + */
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
> >  
> > @@ -655,6 +679,8 @@ static int test_cpucg_max(const char *root)
> >  	char *cpucg;
> >  	char quota_buf[32];
> >  
> > +	quota_usec = hz != -1 ? USEC_PER_SEC / hz : 1000;
> > +
> >  	snprintf(quota_buf, sizeof(quota_buf), "%ld", quota_usec);
> >  
> >  	cpucg = cg_name(root, "cpucg_test");
> > @@ -710,7 +736,8 @@ static int test_cpucg_max(const char *root)
> >  static int test_cpucg_max_nested(const char *root)
> >  {
> >  	int ret = KSFT_FAIL;
> > -	long quota_usec = 1000;
> > +	long quota_usec;
> > +	long hz = _get_config_hz();
> >  	long default_period_usec = 100000; /* cpu.max's default period */
> >  	long duration_seconds = 1;
> >  
> > @@ -719,6 +746,8 @@ static int test_cpucg_max_nested(const char *root)
> >  	char *parent, *child;
> >  	char quota_buf[32];
> >  
> > +	quota_usec = hz != -1 ? USEC_PER_SEC / hz : 1000;
> > +
> >  	snprintf(quota_buf, sizeof(quota_buf), "%ld", quota_usec);
> >  
> >  	parent = cg_name(root, "cpucg_parent");
> 
> 


