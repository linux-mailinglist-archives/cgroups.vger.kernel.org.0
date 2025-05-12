Return-Path: <cgroups+bounces-8134-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 19A19AB2F7E
	for <lists+cgroups@lfdr.de>; Mon, 12 May 2025 08:20:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A55097A9BA4
	for <lists+cgroups@lfdr.de>; Mon, 12 May 2025 06:19:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E876255247;
	Mon, 12 May 2025 06:20:42 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from us-smtp-delivery-44.mimecast.com (us-smtp-delivery-44.mimecast.com [207.211.30.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B81872550C4
	for <cgroups@vger.kernel.org>; Mon, 12 May 2025 06:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.211.30.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747030842; cv=none; b=cewlWS5MUpg/lKi4vQhLnXWVvMz2sZdW0CFPodUmOdjneIT9d37HmOTXnBXOFmOdmtLF9xegVwIbxS5+LBckrZWRdxtCgs4dKIeeSt75/ByIcgXLAtv9+i7uq6FB2AiFlWXmxhD75Bp1+q39t1I8LOl2sQesYWU27BFCpsPrW70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747030842; c=relaxed/simple;
	bh=GgRr7EQvOf4xJonpu4t5PALoaGC1+8Rwm1kf5s/v4bY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:content-type; b=tpgf2M2PXSJX059AjkDXVRByUJtzT8Cb7YEMZvN916IZxGsL9ZBgWN7nPTZ/t3qKR6gm+3I8BXs6rT2SaXp1GspNUBVuhBL23EXy/2OAg8J3MBgy4AuWRYFfdQewMa2cGyDX8wBIaCQ79D9FwCaEiJFmpD1xy265IKYsUoJGeCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com; spf=fail smtp.mailfrom=gmail.com; arc=none smtp.client-ip=207.211.30.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=gmail.com
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-650-4WutLAkXMKOEofd8dd3e8A-1; Mon,
 12 May 2025 02:19:25 -0400
X-MC-Unique: 4WutLAkXMKOEofd8dd3e8A-1
X-Mimecast-MFC-AGG-ID: 4WutLAkXMKOEofd8dd3e8A_1747030763
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id F0D3319560AA;
	Mon, 12 May 2025 06:19:22 +0000 (UTC)
Received: from dreadlord.redhat.com (unknown [10.64.136.70])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 844AD19560B0;
	Mon, 12 May 2025 06:19:17 +0000 (UTC)
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
	Waiman Long <longman@redhat.com>,
	simona@ffwll.ch
Subject: [rfc] drm/ttm/memcg: simplest initial memcg/ttm integration (series v3)
Date: Mon, 12 May 2025 16:12:06 +1000
Message-ID: <20250512061913.3522902-1-airlied@gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: E39OAwRLf3_DA-DiPowBLyeCJBzFh2qIY7rzPyoX9vs_1747030763
X-Mimecast-Originator: gmail.com
Content-Transfer-Encoding: quoted-printable
content-type: text/plain; charset=WINDOWS-1252; x-default=true

Hey,

This is my 3rd attempt to try and integrate ttm and memcg accounting.

I've tried to take on board the feedback given on the last series, and
made some compromises to try and close in on the solution.

Feedback:
1. memcg folks didn't really like the gpu specific stats due to a lack
of global stats being exposed.
2. After consideration of the resource level memcg accounting, I tried
to reason about swap evictions a bit and couldn't come up with a good
way to make it work, so I moved back down to ttm.
3. Use a placement flag instead of ctx flag.

This series starts by adding two per-node stats to the mm layers,
to track memory allocated to the gpu in active use, and memory sitting
in the reclaimable ttm pools.
Then it adds the memcg stat for active gpu as before,=20
(reclaimable is not accounted to a memcg at all).
I didn't go back to use __GFP_ACCOUNT and manual stat tweaking, because
kmem is definitely not the correct place to account this memory. This
memory is never used by the kernel, it's used by userspace and the GPU
in nearly all cases, so I think accounting it under kmem is very wrong.
I'm hoping adding the global stats might alleviate any concerns.

I had to move back to ttm_tt accounting instead of ttm_resource, as
when a resource gets evicted to swap, the memory is freed and the memcg
accounting should be updated correctly, as such I ended up going back
to adding the accounting in ttm_tt population paths.

Regards,
Dave.


