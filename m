Return-Path: <cgroups+bounces-15730-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2OPuE1qhAWpKgwEAu9opvQ
	(envelope-from <cgroups+bounces-15730-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 11 May 2026 11:28:58 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 7051F50AE22
	for <lists+cgroups@lfdr.de>; Mon, 11 May 2026 11:28:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 1FB01304C68B
	for <lists+cgroups@lfdr.de>; Mon, 11 May 2026 09:18:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A0513BB9F1;
	Mon, 11 May 2026 09:18:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="I+z/64oH"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CED603BD64E
	for <cgroups@vger.kernel.org>; Mon, 11 May 2026 09:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778491095; cv=none; b=tqzhl9P/00S2S3CdzUUz0Tjy2ZcJNSR+IrANTZvCryLw0Ro8iI+vqheL5KSHezQNH0o3MI7PJpu/qPd16LwwNmkgn103LbYbEUf+2G6PPkXJtXayw1Xzj3UbCVZ5IrijkBsPCxk5FwDPgRpxPMn4FF96G2OoCs/VCbFOKrWi0Rs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778491095; c=relaxed/simple;
	bh=nSe2Nn4f2ITSSXFBKZ2su1ePGkT4Wk1+TU+wEij1zsA=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=orgkRzZYMUyMEoXew5Uc9+Q/zYbugLbuwX0r+zoUZ1nKPlUaMjRVwTzYTRgTd86kpWucNsXjUU4V/cjix2UWeFUWlcpIcUeKbjPSjTl1fjqEwCyHokcCix3TIUGwoQJC9ehOTpOWSy5kH5EZZWtKdKSxFcKKa2zD7ZKYPkafJ3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=I+z/64oH; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778491092;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iLM8TzsbRVGpY2e4PftnfvvBND0/Sp489AB6+kcyCjM=;
	b=I+z/64oH70jbaqwrtQvLUoCcTmard0MHmzyyCnuJQ5Lgc37Uy/v094yfi8HowgGuRt7t1g
	jaOrUvjThd5IZxYd7t5qI7bC4jBmGtsliOD0k37Mo50dvgSrhPV5SN41xmfLEp3r0nKudc
	u/4gD0fcriJRL8cxvKy1mwi1KhuNin4=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-644-tL4UKDKBNQmNowv-cYZGsQ-1; Mon,
 11 May 2026 05:18:09 -0400
X-MC-Unique: tL4UKDKBNQmNowv-cYZGsQ-1
X-Mimecast-MFC-AGG-ID: tL4UKDKBNQmNowv-cYZGsQ_1778491087
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2BC891956088;
	Mon, 11 May 2026 09:18:06 +0000 (UTC)
Received: from jlelli-thinkpadt14gen4.remote.csb (headnet01.pony-001.prod.iad2.dc.redhat.com [10.2.32.101])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 901FF3002D30;
	Mon, 11 May 2026 09:18:00 +0000 (UTC)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v3 2/2] cgroup/cpuset: reserve DL bandwidth only for
 root-domain moves
From: Juri Lelli <juri.lelli@redhat.com>
To: Guopeng Zhang <zhangguopeng@kylinos.cn>
Cc: Waiman Long <longman@redhat.com>, Tejun Heo <tj@kernel.org>, 
 =?utf-8?q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>, 
 Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, 
 Juri Lelli <juri.lelli@redhat.com>, 
 Chen Ridong <chenridong@huaweicloud.com>, 
 Johannes Weiner <hannes@cmpxchg.org>, 
 Vincent Guittot <vincent.guittot@linaro.org>, 
 Dietmar Eggemann <dietmar.eggemann@arm.com>, 
 Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, 
 Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>, 
 K Prateek Nayak <kprateek.nayak@amd.com>, 
 Gabriele Monaco <gmonaco@redhat.com>, Will Deacon <will@kernel.org>, 
 linux-kernel@vger.kernel.org, cgroups@vger.kernel.org
In-Reply-To: <20260509102031.97608-3-zhangguopeng@kylinos.cn>
References: <20260509102031.97608-1-zhangguopeng@kylinos.cn>
 <20260509102031.97608-3-zhangguopeng@kylinos.cn>
Date: Mon, 11 May 2026 11:17:48 +0200
Message-Id: <177849106876.40525.12840295489106702848.b4-review@b4>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1778491073; l=862;
 i=juri.lelli@redhat.com; s=20250626; h=from:subject:message-id;
 bh=nSe2Nn4f2ITSSXFBKZ2su1ePGkT4Wk1+TU+wEij1zsA=;
 b=2aQwcLLQLj1sPJWCb8JOAVVG1A+Abf/wHGlsn+qHuU/BjzAjo7Y4yHXRk38DTwdtPoOb/YWHR
 fLxbP0qKCaoCo8CLCBURPiIi+mK0JiKxr63RmWH68u7YevlP7PLMy1J
X-Developer-Key: i=juri.lelli@redhat.com; a=ed25519;
 pk=kSwf88oiY/PYrNMRL/tjuBPiSGzc+U3bD13Zag6wO5Q=
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Rspamd-Queue-Id: 7051F50AE22
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-15730-lists,cgroups=lfdr.de];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	DKIM_TRACE(0.00)[redhat.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[juri.lelli@redhat.com,cgroups@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[cgroups];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[kylinos.cn:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On Sat, 09 May 2026 18:20:31 +0800, Guopeng Zhang <zhangguopeng@kylinos.cn> wrote:
> cpuset_can_attach() currently adds the bandwidth of all migrating
> SCHED_DEADLINE tasks to sum_migrate_dl_bw. If the source and destination
> cpuset effective CPU masks do not overlap, the whole sum is then
> reserved in the destination root domain.
> 
> set_cpus_allowed_dl(), however, subtracts bandwidth from the source
> root domain only when the affinity change really moves the task between
> root domains. A DL task can move between cpusets that are still in the
> same root domain, so including that task in sum_migrate_dl_bw can reserve
> destination bandwidth without a matching source-side subtraction.
> 
> [...]

Acked-by: Juri Lelli <juri.lelli@redhat.com>
Tested-by: Juri Lelli <juri.lelli@redhat.com>

-- 
Juri Lelli <juri.lelli@redhat.com>


