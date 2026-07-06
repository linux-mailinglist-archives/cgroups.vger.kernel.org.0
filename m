Return-Path: <cgroups+bounces-17529-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id loLdM3lfS2pQQQEAu9opvQ
	(envelope-from <cgroups+bounces-17529-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Mon, 06 Jul 2026 09:55:37 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AB7870DD28
	for <lists+cgroups@lfdr.de>; Mon, 06 Jul 2026 09:55:37 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=PuN7eygj;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17529-lists+cgroups=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="cgroups+bounces-17529-lists+cgroups=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5636130036C5
	for <lists+cgroups@lfdr.de>; Mon,  6 Jul 2026 07:55:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0FD13C65FD;
	Mon,  6 Jul 2026 07:55:35 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 902853ECBFB
	for <cgroups@vger.kernel.org>; Mon,  6 Jul 2026 07:55:29 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783324533; cv=pass; b=qMZlu+7wZKz3AmXtuezvZ3CJhMws0aDC6iU/zuoyH7o9gBgVRoG2S6IyTd2g1iwcG2ht/54/Y5bfjzIe6gY43U1Ll0+rrf/kPmLrpk/qL9lfskeIaEl3xx/boyacJ+AiVFUOFPwmpph2saU5EPJ7usPbbqIvsvMuYL1c0EBTflg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783324533; c=relaxed/simple;
	bh=/XEVNZfbYRL67+UpgbRqTZBqZTbyV1Rm07jDf3o30m0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OHgGSpp0AftB2mXMJNBKZvFPn4sq7xOJNWoEmaZpYCeOploVvDi3rzjX6gJ+RjDdxpNP+N3D8uZCI2jJnKQVTML8efLdFZWmqnPw8MGABdON5BMDEEYv0yCuG/XYc3Tn4kSnxC2ANZyQ3ekMC8KG32nW1r9pZ1bBN1xu1pN6BDo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PuN7eygj; arc=pass smtp.client-ip=209.85.128.169
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-8111c0c7561so27253157b3.3
        for <cgroups@vger.kernel.org>; Mon, 06 Jul 2026 00:55:27 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783324526; cv=none;
        d=google.com; s=arc-20260327;
        b=OZs+V1dKcg6TYajdwC7PSQ7aj517g/wDOB+CEn/wOlkDb6n2rF2dyxQyF+PSwvtW8D
         JWhX3nIdKjJzlGEkyFeza/ZUb3ydXrllMxFEwKv5sjfV2nCoxHxCYmg7bfTmcetHxZ2z
         zuolIcfq6SNzLzAMoyDglmZTndw9RyyQqVoy1QqBeKkVMjTmZaDq4FSslV/HOb3E/u92
         Ch7LORuLUtnU7KNUN5IXJx6Xmkec82fw16C3fL6hAW9EDV1Zl2TYpXsEp0qO8rRds45i
         2bzg1jdgQ4T6i/QSO/vbi9jtMfxIDuxJt4/EZIRN0P/WU67+Mydzuh/3/eSiC6FL4g+9
         CYgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=/XEVNZfbYRL67+UpgbRqTZBqZTbyV1Rm07jDf3o30m0=;
        fh=c9ShkdkLKioP5T2W9jvF4vgwBe3KaThCeJByGLkSIRs=;
        b=iClaOV1HNL2qaoxAStWTrUf9eOm15pt/4RVy4lUxYWLpYrCmjPoCcLC+oAyfkTd1ZA
         e/rjjwJunxpT9UaWK3f5v54L459feFeUfnVhlzpHOiDTYFLEMwr96/x0OilpKTXn662E
         LsjunSQteZcauBe/tQJDTa8PTIru1r3N7gkIum6dEdpmC0aiiHtgfpL5Y/mePMuB3BKH
         ZCMsP+Gf57DZXhenpmQ/BU6/tpmKXYRUl14omgjFhvNfYOkp7iy/M87Ip6MGiyWDGAiN
         yn6X30SuHuTZuR+siM57z9rQLg4JQiLb1fmwj95PuS692LoCCAyJHNPRZ9jIwHEe8JVp
         1oNg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783324526; x=1783929326; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=/XEVNZfbYRL67+UpgbRqTZBqZTbyV1Rm07jDf3o30m0=;
        b=PuN7eygjWsCVcaL2vkCWpVFyy4a/f0OFwbEvrzJCfUWDs4Iytu8WvhdtCfT/4c6NtU
         afyXnInX2K1P/r8rNK7jDjrcojnnZnoQaWdTCjVXeMjIRCcni+T7lqkfWLwhgm+mlZvh
         vBV0ncjPdKPLeYXvT0bpnua53GRIDc+Ifnuhy/5W4IHT40CEwEmFtuNOL5H6jEKNnz1F
         kAmTurhy0oa0I1Et+LQSOcr5VCJ4yFdRuaWr9Nb0Cc/4Gyjlop/sZTovOJJdiRzz8HXc
         3fF79pMp1NqiPtCxbt81uykjSUjf/W0RCciEkPIcbQ2454Y+0VuOFVSIH+FHZUMpF9aH
         1mLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783324526; x=1783929326;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/XEVNZfbYRL67+UpgbRqTZBqZTbyV1Rm07jDf3o30m0=;
        b=UBUDuzOczUWFzJX7pr5mbjNaWGv8akrrnx+ZTOOR/z1nVgmEYD/6pLMbZDfYhuwRWC
         qua+DCKU0xBQkvbKaW6yIBM6Ycby9ypleGbgsK/K0pGAobyqkM5MzPUuSpwJYYsL3RBU
         hl57Iayai3ydZKwpahp1e2GhS5/fzgXCIAYx+e1+7glbPds3YBpDuh4p34lgRt51hndZ
         dyuy3aOVxEc/YMzBZcFKMw/CT2LWq+rNphIGdx2geCjNpS95dZIhNeQg5UdGw9UYnVr0
         r5BPPaXHmE2EC+Zs7FkMtJvZdWmGeNNWnsOyTi+Ae5EwJy/6OKoRfQrLUtUfLFwN9O0P
         KWYw==
X-Gm-Message-State: AOJu0YzDJfGvh7ERE+uavWN5qswg6NTRSvBvh47dzfBuhgZIT+vECLJD
	CcGATDUGh9dQ4eDwVHdBgLCrzQS66+W6T5xXrfeTTh8KgBFpXmBrlcdWWn4WGIHZl8QFmJ9Dd7a
	c2KdFUtND2Y1TPJpgg3GeUe2ZR9sWHpY=
X-Gm-Gg: AfdE7clSwdBl6dp2V9oFga7B0SFjDbPyAJKl0crzxnT2dnRM2pzFr1yMwZElbEK4fcz
	p374Eo5MG+YjLRx5ym3U1rJYA6oCOcr1pxZyHkWa62sYmSaOPjmVgtotmXaQbXIQbnqmH/qI4Qk
	U02r8VD2hzTvqfcJk2fzAU6Iu4sD8B0fkHrMubK3bjksrS3dPMNeVGtVE1ffFz7fUNhqi73YkRr
	BxLdw4cg6deGGHYnCFhMwcnZstNbUHomsLGIDsZuQcXHnAKF0km33GiKLFpf2yZ64F9zY8HjPK+
	z83igRKMeFSnKpQsKsE2JB4FIZdnMfK+B0R/m825SaFNJ/aMVdYzexhO9A==
X-Received: by 2002:a05:690c:b19:b0:80c:85b6:7654 with SMTP id
 00721157ae682-817398ee8acmr90492207b3.57.1783324525215; Mon, 06 Jul 2026
 00:55:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260706052330.1110909-1-airlied@gmail.com>
In-Reply-To: <20260706052330.1110909-1-airlied@gmail.com>
From: Dave Airlie <airlied@gmail.com>
Date: Mon, 6 Jul 2026 17:55:04 +1000
X-Gm-Features: AVVi8Cfx-dDIbhjl6PnXaEFhBzsvAKm5asFdkh4qpLxeTgixFJOzjr0UZq9aong
Message-ID: <CAPM=9txKzx6qji23YpY=d6Wrd-se-abZoOmDUW32HCx5YsL0tA@mail.gmail.com>
Subject: Re: drm/ttm/memcg/lru: enable memcg tracking for ttm, xe and amdgpu
 driver (part 2) (v2).
To: dri-devel@lists.freedesktop.org, tj@kernel.org, christian.koenig@amd.com, 
	Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Shakeel Butt <shakeel.butt@linux.dev>, 
	Muchun Song <muchun.song@linux.dev>
Cc: cgroups@vger.kernel.org, 
	Thomas Hellstrom <thomas.hellstrom@linux.intel.com>, Waiman Long <longman@redhat.com>, simona@ffwll.ch, 
	intel-xe@lists.freedesktop.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:dri-devel@lists.freedesktop.org,m:tj@kernel.org,m:christian.koenig@amd.com,m:hannes@cmpxchg.org,m:mhocko@kernel.org,m:roman.gushchin@linux.dev,m:shakeel.butt@linux.dev,m:muchun.song@linux.dev,m:cgroups@vger.kernel.org,m:thomas.hellstrom@linux.intel.com,m:longman@redhat.com,m:simona@ffwll.ch,m:intel-xe@lists.freedesktop.org,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-17529-lists,cgroups=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER(0.00)[airlied@gmail.com,cgroups@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[13];
	FORWARDED(0.00)[lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[airlied@gmail.com,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[cgroups];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4AB7870DD28

On Mon, 6 Jul 2026 at 15:23, Dave Airlie <airlied@gmail.com> wrote:
>
> This is just a repost with a number of sashiko identified problems that I fixed.
>
> I committed the vmstat counters and list lru changes, and they are now in tree.
>
> This is the remainder of this series. Intel have expressed interest in getting
> this landed for xe, we can drop the amdgpu changes for now if they can't get
> across the line.

I've put the latest code at
https://github.com/airlied/linux/tree/ttm-memcg-objcg

I've been fixing more sashiko found issues in there before I repost in
a few days.

I've reordered things a little in the branch but mostly the same code.

Dave.

>
> I've dropped all previous acks/reviews.
>
> This series adds the memcg counters for GPU active and GPU reclaim to align
> with the two global vmstats. It adds an accounting flag to TTM alloc/populate,
> and enables memcg tracking and shrinker support in TTM.
>
> Then it adds amdgpu and xe support.
>
> I think for this to land, Christian holds the main objection which I still fail
> to fully understand beyond it doesn't solve all the problems we ever have had
> with cgroups and drm, so we shouldn't even bother, and maybe we could do it at
> the object level, and integrated with dmem, and android cross process accounting,
> but I still feel this is a good baseline.
>
> I think this is the right layer to hook this into TTM, where we allocate memory
> and I think accounting for this memory in a proper way should be done.
>
> Intel folks (Thomas/Maarten) please review and express concerns as well.
>
> Regards,
> Dave.
>

