Return-Path: <cgroups+bounces-15369-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UD0WB8Xc5WnNogEAu9opvQ
	(envelope-from <cgroups+bounces-15369-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 20 Apr 2026 09:59:01 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id ADCAE427F05
	for <lists+cgroups@lfdr.de>; Mon, 20 Apr 2026 09:59:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A701D300A120
	for <lists+cgroups@lfdr.de>; Mon, 20 Apr 2026 07:58:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D3153859DF;
	Mon, 20 Apr 2026 07:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aclRDNpQ"
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6B29346FB5
	for <cgroups@vger.kernel.org>; Mon, 20 Apr 2026 07:58:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776671909; cv=none; b=unVDg4g/R80heR6hhV4ieceKMAy352R28swS891pYdt2dynw2t42Xchiqp/5zBo8xpP/Wq2403flUYHfg+wvjZimsXsNw+wF24yYKV3/ICvn5dgoJ29s+40CUfXaCQI5kNnBX2eGlFIBSKUvoxVVD8kmgiWblq9rJpm2iXMw3j4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776671909; c=relaxed/simple;
	bh=X5G5mHY5kq5f3IvFP9CJtL2o3Q9QcWxvNB9CKbkfxyc=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=QaiIWSopIScxRcCkKgzwmFyfkDtsdBDwrztwfPPk7P6yDgRY5WyWxOzeFaqfaznGgu1V1CPPAEJy3jbE5EL2zOdHVcOf5gkdCPnMz/W7j5EGo7bDy6nKJOXQT0+pXXZKYDw1j9wawKGXAfTlPVCCTsOs0zWayZmo3ALFvORq/Vw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aclRDNpQ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776671907;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+eOGQZSG/sTjuYk//asYw4DDdal69kUFJwf3nSU/tY4=;
	b=aclRDNpQmiA1L1vD+LZMC/wOP8gOyHr3lQHzZUbXSwh3SkotBCvJg/TIWScn8fbBEouCwd
	Yxl5Sh/+7Cx+/KxMEK3zdfeLYD52Fpv77zTyYiZ1YIsGmSfBpG21D2+0vUHWNRPa8vKbJe
	quHWpn6OV/XbtprQABJw+0ggOy4p0ho=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-587-UMddlqhUOjKp5ngNkvFJwg-1; Mon,
 20 Apr 2026 03:58:23 -0400
X-MC-Unique: UMddlqhUOjKp5ngNkvFJwg-1
X-Mimecast-MFC-AGG-ID: UMddlqhUOjKp5ngNkvFJwg_1776671901
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CCFCC195605E;
	Mon, 20 Apr 2026 07:58:19 +0000 (UTC)
Received: from jlelli-thinkpadt14gen4.remote.csb (headnet01.pony-001.prod.iad2.dc.redhat.com [10.2.32.101])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 067AE195608E;
	Mon, 20 Apr 2026 07:58:13 +0000 (UTC)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 1/2] cgroup/cpuset: record DL BW alloc CPU for attach
 rollback
From: Juri Lelli <juri.lelli@redhat.com>
To: Waiman Long <longman@redhat.com>
Cc: Guopeng Zhang <zhangguopeng@kylinos.cn>, tj@kernel.org, 
 hannes@cmpxchg.org, mkoutny@suse.com, void@manifault.com, arighi@nvidia.com, 
 changwoo@igalia.com, shuah@kernel.org, chenridong@huaweicloud.com, 
 Juri Lelli <juri.lelli@redhat.com>, 
 Valentin Schneider <vschneid@redhat.com>, 
 Dietmar Eggemann <dietmar.eggemann@arm.com>, cgroups@vger.kernel.org, 
 sched-ext@lists.linux.dev, linux-kselftest@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <e0fea6ec-397c-40a6-9300-a3529a3d1167@redhat.com>
References: <20260417033742.40793-1-zhangguopeng@kylinos.cn>
 <20260417033742.40793-2-zhangguopeng@kylinos.cn>
 <fd28bea7-83bd-48b7-8c3c-ad44474b8b5b@redhat.com>
 <6aca2465-1ea7-417a-beb8-e385fa3902bf@kylinos.cn>
 <e0fea6ec-397c-40a6-9300-a3529a3d1167@redhat.com>
Date: Mon, 20 Apr 2026 09:58:11 +0200
Message-Id: <177667189136.43781.14481765787952757348.b4-reply@b4>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1776671893; l=1803;
 i=juri.lelli@redhat.com; s=20250626; h=from:subject:message-id;
 bh=X5G5mHY5kq5f3IvFP9CJtL2o3Q9QcWxvNB9CKbkfxyc=;
 b=6pUttxV2K5elVOMXaIeZE/fHVnx/DQzeySz6fQ2Z23/WKZo+WL9QdM2KGXIXIo7Lx7XiOSmdY
 7uVb7Ve3NZJDQB9zQZhSj+wAwxJeazNvnT7MkxgSXqyAizLBbYVEq5i
X-Developer-Key: i=juri.lelli@redhat.com; a=ed25519;
 pk=kSwf88oiY/PYrNMRL/tjuBPiSGzc+U3bD13Zag6wO5Q=
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-15369-lists,cgroups=lfdr.de];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	DKIM_TRACE(0.00)[redhat.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[juri.lelli@redhat.com,cgroups@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[cgroups];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: ADCAE427F05
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi!

On 2026-04-19 22:31:29-04:00, Waiman Long wrote:
> On 4/19/26 10:21 PM, Guopeng Zhang wrote:
> 
> > 在 2026/4/18 2:51, Waiman Long 写道:
> > ...
> > Hi Waiman,
> >
> > Thank you for the review and for the Reviewed-by.
> > I think you are right to call this out. Looking at the
> > current logic, !cpumask_intersects(oldcs->effective_cpus, cs->effective_cpus)
> > does not obviously guarantee that the migration is crossing into a different
> > root domain. If the old and new cpusets are disjoint but still belong to the
> > same root domain, it does look possible that we reserve bandwidth on the
> > destination side without a corresponding subtraction from the source side.
> > I will try to reproduce that configuration and follow up with results.
> > my current understanding is that the DL bandwidth
> > accounting is done at root-domain granularity, not at arbitrary cpuset-subset
> > granularity.
> 
> That is my understanding too.
> 
> > That also seems consistent with
> > Documentation/scheduler/sched-deadline.rst, which says that deadline tasks
> > cannot have a CPU affinity mask smaller than the root domain they are created
> > on, and that a restricted CPU set should be achieved by creating a restricted
> > root domain with cpuset.
> 
> A root domain should be created by creating cpuset root partition for v2 
> or using the cpuset.cpu_exclusive flag in v1.
> 
> What is listed in the documentation is the ideal case, but users may not 
> strictly follow the rule.

But, if they don't and try to create DEADLINE task on cpusets that are
subsets of a root-domain, that should fail, as the affinity mask won't
be covering the entire root domain. So no BW allocated (and no
additional data structures) for subsets either.

Thanks,
Juri


