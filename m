Return-Path: <cgroups+bounces-14812-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ICuXDkoxtGmuigAAu9opvQ
	(envelope-from <cgroups+bounces-14812-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Fri, 13 Mar 2026 16:46:18 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3912A2864A1
	for <lists+cgroups@lfdr.de>; Fri, 13 Mar 2026 16:46:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id BFD213076DBE
	for <lists+cgroups@lfdr.de>; Fri, 13 Mar 2026 15:34:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 914023B0AFD;
	Fri, 13 Mar 2026 15:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hoJpjjgu"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDC1737268C
	for <cgroups@vger.kernel.org>; Fri, 13 Mar 2026 15:34:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773416078; cv=none; b=aVSb0CWHDxBOYiABB42yEENmwTcELbegK5ybsUV1ydwRWRBLxOyGrVLXzVX8WYaYzEVasg9c7h8bWiSUhXyjez5qtqhWDaXyENy+uhCq/56hzac79CuaC59Y/iD3UdEOwhsz9Q9nqN4Uc8ptISkKUrECs9PMRlrmhkJqCAReAAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773416078; c=relaxed/simple;
	bh=DJCs/BOdnBM2SbzqKJU+FiU7MEO4v/zuHQo/67Ie+G8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jK4Ky1K6o5UCzZ2jHzRK4tuntD0LmJSRzldu+O+cLyF+LrkuB+u43hv3DeWg6J8zodq1MaObOZ4unZlFZpw9hUIMH6pOHocD/wvAR36Q1roaCLvJDNW3/eIGCr7vTzSug9OPy94gvNmUak83zyHH7jV2tWWVYnPqUemThzYe29I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hoJpjjgu; arc=none smtp.client-ip=209.85.210.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-7d75e74f5adso2335616a34.3
        for <cgroups@vger.kernel.org>; Fri, 13 Mar 2026 08:34:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773416076; x=1774020876; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qxJi/zSl5l+Hb0RVk/iR14eLBTshpKrTciXowhZG1gg=;
        b=hoJpjjguZz8KgXSUf/mxLm0fqcz/39ocyGNN7Qyk2ojB4Nrusoy5qsU9JY3DWvmd05
         fKkOoGyGr8ueRb9kn0NQl6DameyvVTlreL5QwzDihVINUF3s61Lks+M493A8x6qZ8Usm
         9cuHd8LQ9kXF7mkHNxqJOePPQxYBLIrzA3RACxgAzUAyJWmWsLsW0VcpKy+DmNhXZ6v5
         mdXnQnZXYYhKlc9kSofu6jbhu+cVeHl6XT6inqE4pUQE41FbW84BWUq6ozOaLxXIEFxB
         rV+x2q8LfhROWQ8ZCeAFhrDqQ3dQP4dp5w3ry8JNCkRaR1Ra4IMCalMjZ1ehr+PMvP+x
         bthQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773416076; x=1774020876;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qxJi/zSl5l+Hb0RVk/iR14eLBTshpKrTciXowhZG1gg=;
        b=NmnLTrcyD/6aGL6Up1tyzvOAC9le94CtSwkT9BaxqqkqjMzOqRkBwR3Bl90gp0tBx0
         P0U6af2P6mpidd00Ylgur/nFYK8YVllBI3iBqiwIZgN9GzpRTE8BqTL5YPMdQCTDWfpT
         LgIlhyWkqO/1ao7UzoYJ65OxZMSq7ZtM95DKoWfiEY/jetcNuHCbsUX16oAA4Z5JNXBp
         edGJpFBbNCJzUFdpSGrjzgDyibZgwaykZHauH4OX/fbQ7sqXcbetak94cYOCWO/yU6qO
         vS3kRRQ1c699nqgSea3x34ZnZn61CuDhznZJHqHQMD3cKsd7lf+E4OpeAIxPj4SM1iW3
         DrvQ==
X-Forwarded-Encrypted: i=1; AJvYcCVwGLQ9q5i4lFpnQNv9mNtg1cghpRcZJOOx4smWvLUml+n+BBZ4ttftoNv6Wndu9a6GHtDfykMo@vger.kernel.org
X-Gm-Message-State: AOJu0YzMzFKZMBDo3vCerUYOqonFNqM5CORQUXWGng4+I/S7qv77HQXE
	Ky7BsMEfZTQD/HjLGzLZuXgOQnWbAmNl1bTJpuNSMJinzziiUI38sdHk
X-Gm-Gg: ATEYQzwxgyHmKzrTsqAQ7vXsBsNlOFbIbfsTlid+Hpu+uQYCvdDEMlG3zocTf2M+fej
	Z/0eKvT0VFtvyxXHlchyxc/0njexxdXm6++JN6xqCLzclPPwym1QAMCJ2dDY5S2r+/SCogZKHGd
	fwzKdfUff0C6zcO7TSGujQwUOa0j587MlWTpYpJS00at6WFdJf/ReBrJC4PEYrzzyH/4pizDt0E
	yQ2rw6AlN2fZpr6RyzCsmLBvUzsOTM0EnGYhIOh9NQ2D0M292NiCytf52ngLtxEesp4Se3f1C1X
	acgLBWgs0E/JL0PY2xVyg5vNeOycuRf1l1uohZfpye/LEvE6IAWEhi93H9Gau9yFNEK5qfCA21u
	oW1c5P3j1f4G6TBn2qp14t+6zgHfrL3RPo4HielzqfLXVxpVmmuNxBTAa+RZ6zkQTW6avZDJhW7
	izlHold5Eh9yiqiTN7SlCjxw==
X-Received: by 2002:a05:6830:6a11:b0:7d7:5d69:819d with SMTP id 46e09a7af769-7d782619ed7mr2747874a34.34.1773416075930;
        Fri, 13 Mar 2026 08:34:35 -0700 (PDT)
Received: from localhost ([2a03:2880:10ff:5a::])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7d76ae90586sm7005201a34.22.2026.03.13.08.34.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Mar 2026 08:34:35 -0700 (PDT)
From: Joshua Hahn <joshua.hahnjy@gmail.com>
To: Johannes Weiner <hannes@cmpxchg.org>
Cc: Minchan Kim <minchan@kernel.org>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Yosry Ahmed <yosry.ahmed@linux.dev>,
	Nhat Pham <hoangnhat.pham@linux.dev>,
	Nhat Pham <nphamcs@gmail.com>,
	Chengming Zhou <chengming.zhou@linux.dev>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>,
	cgroups@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	kernel-team@meta.com
Subject: Re: [PATCH 07/11] mm/zsmalloc, zswap: Handle objcg charging and lifetime in zsmalloc
Date: Fri, 13 Mar 2026 08:34:33 -0700
Message-ID: <20260313153434.4074128-1-joshua.hahnjy@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <abMzKa27khxDLO_D@cmpxchg.org>
References: 
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,chromium.org,linux.dev,gmail.com,linux-foundation.org,vger.kernel.org,kvack.org,meta.com];
	TAGGED_FROM(0.00)[bounces-14812-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[16];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joshuahahnjy@gmail.com,cgroups@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	DBL_BLOCKED_OPENRESOLVER(0.00)[cmpxchg.org:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 3912A2864A1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, 12 Mar 2026 17:42:01 -0400 Johannes Weiner <hannes@cmpxchg.org> wrote:

> On Wed, Mar 11, 2026 at 12:51:44PM -0700, Joshua Hahn wrote:
> > @@ -1244,6 +1297,8 @@ void zs_obj_write(struct zs_pool *pool, unsigned long handle,
> >  	if (objcg) {
> >  		WARN_ON_ONCE(!pool->memcg_aware);
> >  		zspage->objcgs[obj_idx] = objcg;
> > +		obj_cgroup_get(objcg);
> > +		zs_charge_objcg(pool, objcg, class->size);
> >  	}
> >  
> >  	if (!ZsHugePage(zspage))

Hello Johannes, thank you for your review!

> Note that the obj_cgroup_get() reference is for the pointer, not the
> charge. I think it all comes out right in the end, but it's a bit
> confusing to follow and verify through the series.

Thank you for pointing that out. I'll try to make it more explicit via
the placement.

> IOW, it's better move that obj_cgroup_get() when you add and store
> zspage->objcgs[]. If zswap stil has a reference at that point in the
> series, then it's fine for there to be two separate obj_cgroup_get()
> as well, with later patches deleting the zswap one when its
> entry->objcg pointer disappears.

Sounds good with me. Maybe for the code block above I just move it one
line up so that it happens before the zspage->objcgs set and
make it more obvious that it's associated with setting the objcg
pointer and not with the charge?

And for the freeing section, putting after we set the pointer to
NULL could be more obvious?

> > @@ -711,10 +711,6 @@ static void zswap_entry_free(struct zswap_entry *entry)
> >  	zswap_lru_del(&zswap_list_lru, entry, objcg);
> >  	zs_free(entry->pool->zs_pool, entry->handle);
> >  	zswap_pool_put(entry->pool);
> > -	if (objcg) {
> > -		obj_cgroup_uncharge_zswap(objcg, entry->length);
> > -		obj_cgroup_put(objcg);
> > -	}
> >  	if (entry->length == PAGE_SIZE)
> >  		atomic_long_dec(&zswap_stored_incompressible_pages);
> >  	zswap_entry_cache_free(entry);
> 
> [ I can see that this was misleading. It was really getting a
>   reference for the entry->objcg = objcg a few lines down, hitching a
>   ride on that existing `if (objcg)`. ]

Thank you for the clarification! I hope you have a great day : -)
Joshua

