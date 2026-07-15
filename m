Return-Path: <cgroups+bounces-17861-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 4UIDG4KWV2oqXgAAu9opvQ
	(envelope-from <cgroups+bounces-17861-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 15 Jul 2026 16:17:38 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BE15275F42B
	for <lists+cgroups@lfdr.de>; Wed, 15 Jul 2026 16:17:37 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=cmpxchg.org header.s=google header.b=Xym1z0s0;
	spf=pass (mail.lfdr.de: domain of "cgroups+bounces-17861-lists+cgroups=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="cgroups+bounces-17861-lists+cgroups=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=cmpxchg.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 250B1308CD4B
	for <lists+cgroups@lfdr.de>; Wed, 15 Jul 2026 14:00:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E17832A3C9;
	Wed, 15 Jul 2026 14:00:53 +0000 (UTC)
X-Original-To: cgroups@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB23130276A
	for <cgroups@vger.kernel.org>; Wed, 15 Jul 2026 14:00:50 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784124053; cv=none; b=iVgDQSHjNlZufLaCHJHRQFVNufGEFTarY01wJICQC8vHrqvQLrMp6j14vHKxXaNXJBolOe6rmzesTRJHZhs4u/cQgjTlNNBkSxuxtxApE+YoPE0xtQIe4S4M4X9jVnwYhgrBVl2QSJEZcHTVMyu6i/FjaC+21/I0n8NicFxauqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784124053; c=relaxed/simple;
	bh=NqH9gBKIbRjL89vi05p9Hog3cwkQA8VspLKF8/hJCJs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a934NSCzct+5V98ghr0dIAk7lQxA8PwJylFvOsUL8UixJy/jEVp1Rk2t/Uw9vtWW8gkJITE1/oivy1lBM8PKyAfIAmFtGK17zjZz/K0RzwCGDWg/g+YGqlSAqSy3sm3DKUOfsN7pVwjzn8yzWeU05yuuETTHypIW56jq5937CNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg.org header.i=@cmpxchg.org header.b=Xym1z0s0; arc=none smtp.client-ip=209.85.221.45
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-476a130c138so2138913f8f.0
        for <cgroups@vger.kernel.org>; Wed, 15 Jul 2026 07:00:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg.org; s=google; t=1784124049; x=1784728849; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=NqH9gBKIbRjL89vi05p9Hog3cwkQA8VspLKF8/hJCJs=;
        b=Xym1z0s0Jh+PX4N4RpM4yBobkKyRMv64wzXs1I/S+gRp60tF0vzqW+zA4mmp4OYers
         C+xWFsqifK25kHte28e3mtlr6PSUmmnjpqqR+fVg5pVdKp5TpsndYm6oty6J7TLcLno+
         2YXmMC2p0sm7HdttzcnwpLfxa9G7dQLChOV7oo39dns2Sd3WEyDJnOy5yvuQTWrrHK+a
         Fyt2Sgtu+ByiyTEzCCXcPbqUj6iiVWlcEZRFwLUQGZmIMCBdhyUURXA/nCO1JRlcRPdc
         RZGphOjj1/+hRBrRAJ/gZzoNdFH1257PW51bSpaf5fJTHdItzSlGXUQl6mpK2TezAECR
         4uLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784124049; x=1784728849;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=NqH9gBKIbRjL89vi05p9Hog3cwkQA8VspLKF8/hJCJs=;
        b=By+MR5MfirR2Fh24BeVnZab8uCJwmH4N8O0PblRFCIpnIsucJkxTwANBRO05osfRrw
         dxxYhKBtbzpeXDsr5qLWMtVb6IOToOmP5KDQzJK6LipGMONPGg4L+jMPjEB7oLPc6wEp
         CFgoRTOXHkqgHXvnHkiO22emio3zl6aGfnSRIXt9HsuKmI9EM4CG9Vj8ADASCw69wdsR
         G+mWN+2AOA7dAp+76LkxqXr8AsGtRqMBvc1buJ6E27u9A/nmVob2zt53DZuP4uASLqPe
         3IRfBBwN7KPaA3d4hvOJQ09/TZlm//D4OA5htzI3WXKXIDDZfrOlWLVSEgFojXJbt26x
         pG1g==
X-Forwarded-Encrypted: i=1; AHgh+RoMjSOOBlWatC2ojL9ahVYMS1C9PJjI6Xc+xkuPL5ypai9Xu7ZN6rBzhnhWnl2TpzyFYZmVVzb0@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4u/EXqEvvF/kvCQkFG/yCxJNR/sDY157BuUEYZLGbKQtysgAu
	MG40/qB9caUFh6RW4vPwTXwIMH6EpFPBi1XKJwFhYSADIWNJ15ogcWi/u9Ak1Wh4JWg=
X-Gm-Gg: AfdE7cl0lVrcnkUJwBg0EPwZH7jqdCi0/BYO1GEElS6LjllFoVZbYdGzZQ7Be8NmDji
	jcHcucFGbwB02jG0BduW4zT4nseE7ORhGTQ5z3OvYKgUY4r6KzksMVO0u5F/rXm0fdOFEEE9jC9
	05mq8xjHke9RPEPW+owp+cxQeNStYSFD5kkkIJL9wokqU7W8AGUlQ/UojRgxyC3hnm/3KwuSerl
	cPlIykH6oltUjkHDhokIglsaC3d7B7hSOeO63PXRTap3h9MGd2aQiYpgPaKqQB5/xlEKFn7oY+M
	SrkK6Neg5WoL6sm3mX2TkF4VNIBxAnMJXz0GEB0KtcfSjTREriqJidSMXkEcwt33UIs6kT6UgJW
	JRU+ceZLfBH8VkZ5nH42FsZRfmWWGKjwgHiiD0+xM0kDNlUJTmvog35TL8vXHWDN5ffQGlaW020
	HI6Q73jtYah36MZQ==
X-Received: by 2002:a5d:64eb:0:b0:472:d154:facf with SMTP id ffacd0b85a97d-47f2dd2bd5fmr22313384f8f.42.1784124048779;
        Wed, 15 Jul 2026 07:00:48 -0700 (PDT)
Received: from localhost ([2a02:8071:8280:d6e0:1353:8eb8:c84a:b6d4])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f464a9879sm17535061f8f.22.2026.07.15.07.00.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2026 07:00:48 -0700 (PDT)
Date: Wed, 15 Jul 2026 16:00:46 +0200
From: Johannes Weiner <hannes@cmpxchg.org>
To: Zicheng Wang <wangzicheng@honor.com>
Cc: akpm@linux-foundation.org, yuanchu@google.com, tj@kernel.org,
	mkoutny@suse.com, corbet@lwn.net, kasong@tencent.com,
	qi.zheng@linux.dev, shakeel.butt@linux.dev, baohua@kernel.org,
	axelrasmussen@google.com, weixugc@google.com, david@kernel.org,
	ljs@kernel.org, liam@infradead.org, vbabka@kernel.org,
	rppt@kernel.org, surenb@google.com, mhocko@suse.com,
	roman.gushchin@linux.dev, muchun.song@linux.dev,
	cgroups@vger.kernel.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
	willy@infradead.org, denghaojie@honor.com, baoquan.he@linux.dev,
	kaleshsingh@google.com, tjmercier@google.com, tao.wangtao@honor.com,
	zhangji1@honor.com, wangzhen5@honor.com
Subject: Re: [RFC v2 0/3] mm/mglru: proactive aging via memory.aging
Message-ID: <20260715140046.GO276793@cmpxchg.org>
References: <20260714121529.2237261-1-wangzicheng@honor.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260714121529.2237261-1-wangzicheng@honor.com>
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[cmpxchg.org,none];
	R_DKIM_ALLOW(-0.20)[cmpxchg.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	TAGGED_FROM(0.00)[bounces-17861-lists,cgroups=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[hannes@cmpxchg.org,cgroups@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[33];
	FORGED_RECIPIENTS(0.00)[m:wangzicheng@honor.com,m:akpm@linux-foundation.org,m:yuanchu@google.com,m:tj@kernel.org,m:mkoutny@suse.com,m:corbet@lwn.net,m:kasong@tencent.com,m:qi.zheng@linux.dev,m:shakeel.butt@linux.dev,m:baohua@kernel.org,m:axelrasmussen@google.com,m:weixugc@google.com,m:david@kernel.org,m:ljs@kernel.org,m:liam@infradead.org,m:vbabka@kernel.org,m:rppt@kernel.org,m:surenb@google.com,m:mhocko@suse.com,m:roman.gushchin@linux.dev,m:muchun.song@linux.dev,m:cgroups@vger.kernel.org,m:linux-mm@kvack.org,m:linux-kernel@vger.kernel.org,m:linux-doc@vger.kernel.org,m:willy@infradead.org,m:denghaojie@honor.com,m:baoquan.he@linux.dev,m:kaleshsingh@google.com,m:tjmercier@google.com,m:tao.wangtao@honor.com,m:zhangji1@honor.com,m:wangzhen5@honor.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[cmpxchg.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hannes@cmpxchg.org,cgroups@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[cgroups];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,cmpxchg.org:dkim,cmpxchg.org:mid,cmpxchg.org:from_mime,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: BE15275F42B
X-Rspamd-Action: no action

On Tue, Jul 14, 2026 at 08:15:26PM +0800, Zicheng Wang wrote:
> MGLRU inverts the reclaim order when anonymous memory is faulted in
> bulk: anonymous pages sit in the young generations while file pages
> sit in the oldest two, so reclaim evicts hot file pages before cold
> anonymous pages.

An aging inversion in the reclaim algorithm seems like an exceedingly
poor justification for a userspace interface to work around them.

