Return-Path: <cgroups+bounces-17288-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id GnhyALgjPWq4xggAu9opvQ
	(envelope-from <cgroups+bounces-17288-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Thu, 25 Jun 2026 14:48:56 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 66B9A6C5B82
	for <lists+cgroups@lfdr.de>; Thu, 25 Jun 2026 14:48:55 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=redhat.com header.s=mimecast20190719 header.b=T3fbCpHg;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17288-lists+cgroups=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="cgroups+bounces-17288-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=redhat.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 236903025D09
	for <lists+cgroups@lfdr.de>; Thu, 25 Jun 2026 12:45:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C0253E122D;
	Thu, 25 Jun 2026 12:45:49 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4B1833987F
	for <cgroups@vger.kernel.org>; Thu, 25 Jun 2026 12:45:47 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782391549; cv=none; b=L4yTH61bywjdiUBvEiYDW/v2kcj06znWueQor/iCq3zKVXMGXYil8omO8RYZAg8NYVbL/Gg6ok9+ZvEf7hwoLt33edpZSWuwzmhe2LBilMzu0VJOLZ/7Dtus0PFRCgewvdXFCM6oWPL70MDRU9QLYylPbJUyVPhxLC1o+qMVyb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782391549; c=relaxed/simple;
	bh=r2P5eA48y32H1bZjwDFCkLFtTjDcfkfC5PzuTzTwAxQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iZh1R3zJt+w9g5J5aiMsyqUHnELH7Mej6t1CupShpghLi/Mu1KorE3hgj/ySdJpw6Zlx+ajaQ1E7tfXhNEtnxrPAKxP2nf5rzu6pOn0c+jPxsKtJKh+JiirtCgBW2j8f1WTuNJTnoLCMm3dXMqfbplI4ML9vJixBE+HjbQi34XA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=T3fbCpHg; arc=none smtp.client-ip=170.10.133.124
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782391546;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=o1fn8ZVw+fDJI0KtIjS3k5qrVd64OuJrrFoJt8QAlek=;
	b=T3fbCpHgrEL102dAGxpGu5Dd0HTrGUD4xoRqmnSAJeaicZIjquCyh+lqdkH+bY1P2UXctH
	t9u+RZ+epmZgITLQ1hEQz4bsCGiMox+EKmBRQzpXgoUccVQl+2/Hmk0Zda9k4nE41T9oRH
	edNXCkYxuBrHkEG+1cvUR3h7SN1sW2M=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-670-mUjIHf6CPDiO-3HAL2RirQ-1; Thu,
 25 Jun 2026 08:45:43 -0400
X-MC-Unique: mUjIHf6CPDiO-3HAL2RirQ-1
X-Mimecast-MFC-AGG-ID: mUjIHf6CPDiO-3HAL2RirQ_1782391541
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id E509E195F16D;
	Thu, 25 Jun 2026 12:45:40 +0000 (UTC)
Received: from oak (unknown [10.22.88.172])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 605FB1800652;
	Thu, 25 Jun 2026 12:45:39 +0000 (UTC)
Date: Thu, 25 Jun 2026 08:45:32 -0400
From: Joe Simmons-Talbott <josimmon@redhat.com>
To: Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
Cc: Joe Simmons-Talbott <joest@redhat.com>, Tejun Heo <tj@kernel.org>,
	Johannes Weiner <hannes@cmpxchg.org>, Shuah Khan <shuah@kernel.org>,
	cgroups@vger.kernel.org, linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] selftests/cgroup: Adjust cpu test duration based on HZ
Message-ID: <20260625124532.GA19617@oak>
References: <20260624160358.430354-1-joest@redhat.com>
 <ajzjLsBNS7rNZV2x@localhost.localdomain>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ajzjLsBNS7rNZV2x@localhost.localdomain>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-17288-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[josimmon@redhat.com,cgroups@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:mkoutny@suse.com,m:joest@redhat.com,m:tj@kernel.org,m:hannes@cmpxchg.org,m:shuah@kernel.org,m:cgroups@vger.kernel.org,m:linux-kselftest@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[josimmon@redhat.com,cgroups@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,oak:mid,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 66B9A6C5B82

On Thu, Jun 25, 2026 at 10:23:22AM +0200, Michal Koutný wrote:
> Hi.
> 
> On Wed, Jun 24, 2026 at 12:03:57PM -0400, Joe Simmons-Talbott <joest@redhat.com> wrote:
> > +/*
> > + * Best effort attempt to get the kernel's HZ value from the config.
> > + * Return the HZ value if found otherwise return -1 to indicate failure.
> > + */
> > +static long
> > +_get_config_hz(void)
> 
> drop underscore from the static function
> 
> > +{
> > +	long hz = -1;
> 
> use the default 1000 here to simplify the callers
> 
> > +	FILE *f;
> > +	char cmd[256] = "zcat /proc/config.gz 2>/dev/null | grep '^CONFIG_HZ='";
> > +
> > +	f = popen(cmd, "r");
> > +
> > +	if (!f)
> > +		return hz;
> > +
> > +	if (fscanf(f, "CONFIG_HZ=%ld", &hz) == EOF)
> > +		goto out;
> > +
> > +out:
> > +	pclose(f);
> > +	return hz;
> > +}
> > +
> >  /*
> >   * This test creates a cgroup with some maximum value within a period, and
> >   * verifies that a process in the cgroup is not overscheduled.
> > @@ -646,15 +670,21 @@ test_cpucg_nested_weight_underprovisioned(const char *root)
> >  static int test_cpucg_max(const char *root)
> >  {
> >  	int ret = KSFT_FAIL;
> > +	long hz = _get_config_hz();
> >  	long quota_usec = 1000;
> >  	long default_period_usec = 100000; /* cpu.max's default period */
> > -	long duration_seconds = 1;
> > +	long duration_seconds;
> >  
> > -	long duration_usec = duration_seconds * USEC_PER_SEC;
> > +	long duration_usec;
> >  	long usage_usec, n_periods, remainder_usec, expected_usage_usec;
> >  	char *cpucg;
> >  	char quota_buf[32];
> >  
> > +	if (hz == -1)
> > +		hz = 1000;
> > +	duration_seconds = 1000 / hz;
> > +	duration_usec = duration_seconds * USEC_PER_SEC;
> 
> I'd do the calculation in usecs
> 
> 	duration_usec = duration_seconds * USEC_PER_SEC * 1000 / hz;
> 
> so that actual duration is more precise (for hz=300 which is the only
> that doesn't divide 1000)
> 
> All in all, make the adjustments for HZ with less code (since I expect
> this will need adjustments for SMPs in future).

Hi Michal,

Thanks for your feedback.  I'll make the changes you have suggested in v4.

Thanks,
Joe


