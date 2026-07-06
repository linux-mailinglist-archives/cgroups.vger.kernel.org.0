Return-Path: <cgroups+bounces-17515-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 1z8UCEAWS2ogLwEAu9opvQ
	(envelope-from <cgroups+bounces-17515-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 06 Jul 2026 04:43:12 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6157D70C2ED
	for <lists+cgroups@lfdr.de>; Mon, 06 Jul 2026 04:43:11 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=fail reason="SPF not aligned (relaxed), No valid DKIM" header.from=gmail.com (policy=none);
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17515-lists+cgroups=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="cgroups+bounces-17515-lists+cgroups=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 009FC300A62B
	for <lists+cgroups@lfdr.de>; Mon,  6 Jul 2026 02:43:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 032743A7D91;
	Mon,  6 Jul 2026 02:43:04 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-44.mimecast.com (us-smtp-delivery-44.mimecast.com [205.139.111.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82D0E3A9605
	for <cgroups@vger.kernel.org>; Mon,  6 Jul 2026 02:43:02 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783305783; cv=none; b=ajqmlJjGP48p6TqJTJBk0rQRy5gcZI/dukNGGVvuYUu6nTnDmzKiMBodG9a0hrUol/ijq7ZEl5vzD9Yv3kIdDKJr4zM+jTk9NXdR2fUVrYcJXE/FTkLvUxr/mfkfvB8tISu7C4RKjH8CjEKMVStvWixICa+Tkjy1ESkPwZp48KE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783305783; c=relaxed/simple;
	bh=Ov6PdTjuk8SAVI4sc7+h/iyRA1ls2mem+qq8xCEfT9A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:content-type; b=aqw6MUqrdRrWZxxUHefnYxtlNzrmWsggMHbaPV4Q+i64BrknGWSIKwHobkMB8JWQA+EGGQQISscuT/duRqVMjFYFxKVSHt77g0TThjX+duOQ0NPaQKaYWsom9JYvUcl7js82u10rzWTz3GUYC3W545Xl8lCQ0v2xdnTa/wwqSh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=fail smtp.mailfrom=gmail.com; arc=none smtp.client-ip=205.139.111.44
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-448-qAdnzgQbO3KdSj3kfVunCA-1; Sun,
 05 Jul 2026 22:41:38 -0400
X-MC-Unique: qAdnzgQbO3KdSj3kfVunCA-1
X-Mimecast-MFC-AGG-ID: qAdnzgQbO3KdSj3kfVunCA_1783305696
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id D5ED21801378;
	Mon,  6 Jul 2026 02:41:35 +0000 (UTC)
Received: from dreadlord.redhat.com (unknown [10.67.32.13])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 5AEB83000B4C;
	Mon,  6 Jul 2026 02:41:27 +0000 (UTC)
From: Dave Airlie <airlied@gmail.com>
To: dri-devel@lists.freedesktop.org,
	tj@kernel.org,
	christian.koenig@amd.com,
	Johannes Weiner <hannes@cmpxchg.org>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Muchun Song <muchun.song@linux.dev>
Cc: cgroups@vger.kernel.org,
	Thomas Hellstrom <thomas.hellstrom@linux.intel.com>,
	Waiman Long <longman@redhat.com>,
	simona@ffwll.ch,
	intel-xe@lists.freedesktop.org
Subject: drm/ttm/memcg/lru: enable memcg tracking for ttm, xe and amdgpu driver (part 2).
Date: Mon,  6 Jul 2026 12:36:09 +1000
Message-ID: <20260706024122.853329-1-airlied@gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 3mv9vG7FohDzKquh9f83kyXYftwCD8t3X-htix_EHzc_1783305696
X-Mimecast-Originator: gmail.com
Content-Transfer-Encoding: quoted-printable
content-type: text/plain; charset=WINDOWS-1252; x-default=true
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.36 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[gmail.com : SPF not aligned (relaxed), No valid DKIM,none];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:dri-devel@lists.freedesktop.org,m:tj@kernel.org,m:christian.koenig@amd.com,m:hannes@cmpxchg.org,m:mhocko@kernel.org,m:roman.gushchin@linux.dev,m:shakeel.butt@linux.dev,m:muchun.song@linux.dev,m:cgroups@vger.kernel.org,m:thomas.hellstrom@linux.intel.com,m:longman@redhat.com,m:simona@ffwll.ch,m:intel-xe@lists.freedesktop.org,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[airlied@gmail.com,cgroups@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-17515-lists,cgroups=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[13];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[airlied@gmail.com,cgroups@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	R_DKIM_NA(0.00)[];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6157D70C2ED

I committed the vmstat counters and list lru changes, and they are now in t=
ree.

This is the remainder of this series. Intel have expressed interest in gett=
ing
this landed for xe, we can drop the amdgpu changes for now if they can't ge=
t
across the line.

I've dropped all previous acks/reviews.

This series adds the memcg counters for GPU active and GPU reclaim to align
with the two global vmstats. It adds an accounting flag to TTM alloc/popula=
te,
and enables memcg tracking and shrinker support in TTM.

Then it adds amdgpu and xe support.

I think for this to land, Christian holds the main objection which I still =
fail
to fully understand beyond it doesn't solve all the problems we ever have h=
ad
with cgroups and drm, so we shouldn't even bother, and maybe we could do it=
 at
the object level, and integrated with dmem, and android cross process accou=
nting,
but I still feel this is a good baseline.

I think this is the right layer to hook this into TTM, where we allocate me=
mory
and I think accounting for this memory in a proper way should be done.

Intel folks (Thomas/Maarten) please review and express concerns as well.

Regards,
Dave.


