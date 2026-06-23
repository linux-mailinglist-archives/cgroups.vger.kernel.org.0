Return-Path: <cgroups+bounces-17197-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id RtHaJFrUOmooIAgAu9opvQ
	(envelope-from <cgroups+bounces-17197-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Tue, 23 Jun 2026 20:45:46 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F1BAC6B97FB
	for <lists+cgroups@lfdr.de>; Tue, 23 Jun 2026 20:45:45 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=kFTrXaGr;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17197-lists+cgroups=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="cgroups+bounces-17197-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 00918303778A
	for <lists+cgroups@lfdr.de>; Tue, 23 Jun 2026 18:45:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24B1931353C;
	Tue, 23 Jun 2026 18:45:42 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1D432D0617
	for <cgroups@vger.kernel.org>; Tue, 23 Jun 2026 18:45:40 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782240341; cv=pass; b=TU5lmLJX17gg8zCvxRly2+033ZAZmVXTqIhVAh2KJGl6veJeWkbHxmthNXbl5rkYXfBOi/KZiE6fPrPTBB+d6YzTrQXLnYa6wlNPetR+txX0KiOY/qdxx4Lk5G6gfhJXOBz2Hq+VxQaMvmn/s21T/JWv+TJ3bjZNNMQuEdCUMHk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782240341; c=relaxed/simple;
	bh=LVwncB4caCHuMDpKbFeo4MHlTUSmtwWDgRh+YGNPGK0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=DB0I+sUsqpjiBPw/W/g6PoIBouutc9V2TzmexLOsGHnBveXGi9dMESE3JuxagY4x2C+4DE4bCRZpOYxDP0/I1+LftPDqYQAa4zaEggpwkTc++hG/9xerZiwRrG6elqEeLFlfnOc5nVcIAWND4AwmFXJHXq6w3BA5NqiR8GEmfeE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kFTrXaGr; arc=pass smtp.client-ip=209.85.221.45
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-45fd464d51fso132571f8f.3
        for <cgroups@vger.kernel.org>; Tue, 23 Jun 2026 11:45:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1782240339; cv=none;
        d=google.com; s=arc-20240605;
        b=gCnm9P4XEFD+RMc9OyC7WJw9NG8b8XldQbr8Zvy5G+HINAijFdkUBVSYtUKHVYdvoH
         itcDqO975g2Yr2Xl0sjr2zQfNhNHKBFKIigKKlcb7LQo/rPxzjbnAAx53gyJdK6DlPtm
         Akteq47z5osMAJOBq/gxB4jlhJG3mSvIegv+hbgHjTxFp2oHmYFHYPLLBTJM9wYGirMa
         Kt9toH7teJ/NRfGYHXjOjb7tMl9uFUQuil4M57aBrveDphwfR7/EifPDzj4SpukqtSkG
         7C+0dkERgRRWSVP6vGBBuoAxP3G9keHaFFSMLl4cj09kCk76O6dfhAIhiKWEuJffhdg5
         gsOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=LVwncB4caCHuMDpKbFeo4MHlTUSmtwWDgRh+YGNPGK0=;
        fh=MjOfwLvbGwaflxMLmFkSYecutag1oxLphGAsFLL4EII=;
        b=BPU0PYNWXZhbl5VVNVSxuADtNgWYRSPYEJqyysygtG7MAbWTRYk5OOy1/AzVPoI5HQ
         WdbTl5z21GM9eyJNjQmz9N0/azae+2i+dgZMVRtaEEipYOADaTSWOjP77Cec+S7pfLeD
         j94ng0lQyZHj3W0+k83r+MdNHsApB9Fl3ab/s3Htjjh/IPgl+bIE+kcfxGTGjZgNB+V1
         wazxm6Ur1g8g/19E6F140Y6gk1v+Ov8oPsgOae/mYFXyYaM1D70/n2r+mBOYf1ZBC9Xr
         n0X7MFhuaRFWiqtyvt///ot95imR2xx4Gc/Lqqe9Ki6Ruqyc7RyuQSPnLx25dMLxOpV+
         +Buw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782240339; x=1782845139; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LVwncB4caCHuMDpKbFeo4MHlTUSmtwWDgRh+YGNPGK0=;
        b=kFTrXaGrBG7wuIVkIV/FxMkwUyGBZjtOJfEw0tLnwFBG3AjOStWaBy4TkxYmcbD2/3
         f0QBf6xVPzvx39yM4ANzHt0nLdoZ+iCzDDk12Fejh1o4/4IyQ4MK/AcVSqLXFYI00sQk
         UvFwRCDUtGfZutDxhWGKptLk3rdLTUXc9M72WHTi2tY9Uh8emya1W1/6rbyKrFie3f9x
         PX9nghHMyM9lc0Vf3xU1pUPxMWkv05hu0ld1wYg05hmQ2IKNnz2cZwFowsN7ZMcfCVE8
         1jLPu5P1npsnu6eMQcroEzZZlNI02xKsDZ42jGYCsHFJtNqPBR2pouDPJinbIwGd3UpQ
         p6xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782240339; x=1782845139;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=LVwncB4caCHuMDpKbFeo4MHlTUSmtwWDgRh+YGNPGK0=;
        b=E5T2KD9St5a8qL5SVOS2O8dOLFUCJW0dyOpHCQQWHzPW9VM/27KeOVV7AiPSjgQMIO
         kPkS+HbzpDC9XyIRiYFEEZtoOx9VW+e6LFCSbj63hiVD57cB8RSo25JnfUViSMcjE/dS
         bPQ7wRIKGRqL7ZUqAwLSbhQszLpWrwgggCOzq2QmVH9kwgEXMtALFHRNyMjeVLHU+nsd
         cIr3VmknM/sAs6ZwLPFb0DehbOhYem+Z2jwZod1TooF3C5az7d4JdekBBxjWJeNiu6rA
         QOAvnaS9VoRNhZhBBccln2OBziJ2XQXD2KIYwZ10Fy+Z8SoaJOufgkl4bEcXJ00oBv5o
         l5sQ==
X-Forwarded-Encrypted: i=1; AHgh+RriFB3kwWzpui8vdNDLYGlCdhVZnRy0SYB8llFhCejZuBowrTw3zWrmFb3NMVPfSDLeZkbkpAHU@vger.kernel.org
X-Gm-Message-State: AOJu0Yzphk10i5DZYRcyz0uqjlabogBW1grwwD0N/kCeiy77tyFSbAbN
	CoPuQT7M5HQitkh4ylKlZltgwwAXFM5046y89VqdZNw2T3mRLro4ekaTvQ69fCPff92RGr4nJ3u
	HMFqQcRJ60OGyUDukmTbRriLsENuRrlY=
X-Gm-Gg: AfdE7cl0zNeyhiBcf0J2cZtScYwlVMPNtSZ6cXT46lJPpb5HzsXNZ7+1q2Re4UBkpvG
	3u4wIeqsmOfMSxWv75gm9yiPRxdeslZeaGzMqFIJzZmViBX4yMF93frYapB/IuM86A3H2bx63TN
	G6yfOR5EiBD4fSn3xpskjAZSYXwrLgoqy8axL0NQod7+xLgcm+CA0p2NBXYBu2owv5HMUC7MNDr
	cwcEsNyizSZmURtSNGhRJ0hwvO6n5qfP21hRXPYe5CnVPqAdGbtQpuY5ITiQPbriI0gy1n/XiC7
	9+WpGoFn0g6DhnZpsZm8XqOa0NYo
X-Received: by 2002:a05:6000:22c4:b0:45e:fa38:c899 with SMTP id
 ffacd0b85a97d-46c084c816bmr138476f8f.4.1782240338997; Tue, 23 Jun 2026
 11:45:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260612193738.2183968-1-nphamcs@gmail.com> <20260612193738.2183968-4-nphamcs@gmail.com>
 <ajnRulrxAKnZavOl@google.com>
In-Reply-To: <ajnRulrxAKnZavOl@google.com>
From: Nhat Pham <nphamcs@gmail.com>
Date: Tue, 23 Jun 2026 11:45:27 -0700
X-Gm-Features: AVVi8CcGflRtAnYhAwHoECRZzxc8TT27o9VDjZ7vOQkQ1fmoj7wrI9DQrKaVgpE
Message-ID: <CAKEwX=PsyKgD5UufUsX138wFnmz9hKfi8zvrbs6gsh4Kj+F+yw@mail.gmail.com>
Subject: Re: [RFC PATCH v2 3/7] mm, swap: support physical swap as a vswap backend
To: Yosry Ahmed <yosry@kernel.org>
Cc: akpm@linux-foundation.org, chrisl@kernel.org, kasong@tencent.com, 
	hannes@cmpxchg.org, mhocko@kernel.org, roman.gushchin@linux.dev, 
	shakeel.butt@linux.dev, david@kernel.org, muchun.song@linux.dev, 
	shikemeng@huaweicloud.com, baoquan.he@linux.dev, baohua@kernel.org, 
	youngjun.park@lge.com, chengming.zhou@linux.dev, ljs@kernel.org, 
	liam@infradead.org, vbabka@kernel.org, rppt@kernel.org, surenb@google.com, 
	qi.zheng@linux.dev, axelrasmussen@google.com, yuanchu@google.com, 
	weixugc@google.com, riel@surriel.com, gourry@gourry.net, 
	haowenchao22@gmail.com, kernel-team@meta.com, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, cgroups@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-17197-lists,cgroups=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:yosry@kernel.org,m:akpm@linux-foundation.org,m:chrisl@kernel.org,m:kasong@tencent.com,m:hannes@cmpxchg.org,m:mhocko@kernel.org,m:roman.gushchin@linux.dev,m:shakeel.butt@linux.dev,m:david@kernel.org,m:muchun.song@linux.dev,m:shikemeng@huaweicloud.com,m:baoquan.he@linux.dev,m:baohua@kernel.org,m:youngjun.park@lge.com,m:chengming.zhou@linux.dev,m:ljs@kernel.org,m:liam@infradead.org,m:vbabka@kernel.org,m:rppt@kernel.org,m:surenb@google.com,m:qi.zheng@linux.dev,m:axelrasmussen@google.com,m:yuanchu@google.com,m:weixugc@google.com,m:riel@surriel.com,m:gourry@gourry.net,m:haowenchao22@gmail.com,m:kernel-team@meta.com,m:linux-mm@kvack.org,m:linux-kernel@vger.kernel.org,m:cgroups@vger.kernel.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[nphamcs@gmail.com,cgroups@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[31];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[linux-foundation.org,kernel.org,tencent.com,cmpxchg.org,linux.dev,huaweicloud.com,lge.com,infradead.org,google.com,surriel.com,gourry.net,gmail.com,meta.com,kvack.org,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nphamcs@gmail.com,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[cgroups];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp,mail.gmail.com:mid,tencent.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: F1BAC6B97FB

On Mon, Jun 22, 2026 at 5:23=E2=80=AFPM Yosry Ahmed <yosry@kernel.org> wrot=
e:
>
> On Fri, Jun 12, 2026 at 12:37:34PM -0700, Nhat Pham wrote:
> > Add physical swap as a backend for the virtual swap layer.
> >
> > With physical swap backing, vswap can allocate a physical slot on
> > demand when needed: as a fallback for zswap_store failures, or as
> > the destination for zswap writeback.
> >
> > Each vswap entry's physical slot is tracked via a Pointer-tagged
> > swap_table entry on the physical cluster (rmap back to the vswap
> > entry).
> >
> > Suggested-by: Kairui Song <kasong@tencent.com>
> > Signed-off-by: Nhat Pham <nphamcs@gmail.com>
>
> I didn't look through the rest of the series, but are there use cases
> for calling folio_realloc_swap() without calling vswap_zswap_load()
> first? I wonder if the realloc_swap API should take the swpentry
> directly and do the load within? Something like
> vswap_alloc_phys(swpentry, folio)?

It's also use on the swapout fallback path! If zswap rejects the page
or is disabled, and memory.zswap.writeback=3D1, then we allocate phys
swap space. We probably don't wanna do zswap_load() there again :)

