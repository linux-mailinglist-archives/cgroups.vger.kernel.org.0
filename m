Return-Path: <cgroups+bounces-14793-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aEHTCk0zs2ntSwAAu9opvQ
	(envelope-from <cgroups+bounces-14793-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Thu, 12 Mar 2026 22:42:37 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C6C927A1D6
	for <lists+cgroups@lfdr.de>; Thu, 12 Mar 2026 22:42:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2CAD431443CB
	for <lists+cgroups@lfdr.de>; Thu, 12 Mar 2026 21:42:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A65392ECE9B;
	Thu, 12 Mar 2026 21:42:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg.org header.i=@cmpxchg.org header.b="pa+XaN5Y"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDCF33F0A87
	for <cgroups@vger.kernel.org>; Thu, 12 Mar 2026 21:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773351730; cv=none; b=gM1GqFsFwKfQlJ/AOQigcdPOZL2bSvq99Q3IGhQXnRJPDFbWPK7J5F/8Fhfl+JDcRmVELc0jghq1WvAO3xd5Epbhkd3TvYuvCqJ+odbkyNLHpR121iZEp+uauOZuNmhb2BgDqWLldMHKUj0vrvLeVv8Qzpy7qNsREhWH5OAeA+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773351730; c=relaxed/simple;
	bh=sgwa46VwlJ5NW0Quir1JmdvJvZe9OmJMk+cKe/4nCDw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XGupGrCc9BXdlhQUWTZ1HTgW48X0zJykIwB1GSrURvRgS+ylriSxjHUkPpS+MVyGyO/O99eONM80uR36QmBQ7HmtLnUSmsiWV+1pve4vtkT6/SK0CU57bGzhXIk5Mujk+kKZeqepkdSVDTo2dY9K5q3/ZXbza29oIEkR5jvtF8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org; spf=pass smtp.mailfrom=cmpxchg.org; dkim=pass (2048-bit key) header.d=cmpxchg.org header.i=@cmpxchg.org header.b=pa+XaN5Y; arc=none smtp.client-ip=209.85.222.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cmpxchg.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmpxchg.org
Received: by mail-qk1-f173.google.com with SMTP id af79cd13be357-8cd8a189f44so154068285a.0
        for <cgroups@vger.kernel.org>; Thu, 12 Mar 2026 14:42:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg.org; s=google; t=1773351726; x=1773956526; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=LyceMyfiqLdgt3XmH3cZvfSKhUu32FwkvwXjXF/XZck=;
        b=pa+XaN5YpMZg8SBNN1OhPtVFuFPTUOQnGYNjSWQX3Zr/YS3Mi5Tfc9Tw+H1/ZwFavf
         WlVxtqlNMVOSkzW6F4cJa34JrNrVd6rvEOJO8CRSqToEOusuIfTsHMtP3PmJub4wy5kU
         7ki2JXCOquEfZjKt09t3NPKYFyFcGQhBpDu9lXBXZG1WSETT6FcDy4heyBx+GwuJOJV6
         B2NFF4OieoRW1NlDSJgjG+52mbrFttzQrnDibirbclC1bTZABALTVX8u1SuLPBEmdtdI
         384joc/3FV/Z9up9YG2u9AVwuLGTzRXQ7xdCA5mO3Y7IM6ukdjxyWfmmS1aIon9Cg5oy
         FM4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773351726; x=1773956526;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LyceMyfiqLdgt3XmH3cZvfSKhUu32FwkvwXjXF/XZck=;
        b=GuZaWPxCoJSNeqF4GkUZAgmAHNjwvue8YCuX9qtWcrK2fv1QPLXOTZpabQ8Y3s8lg7
         EElg0ikZEkaS8CoNWI/wEfp73s7Ji2zD1Zt3S0NHt6cwsntNVayX+xsgTgjpIO61uKao
         MuRo1yLFOu+TN8oT+On1ANnc3f9jd5HyOdFx3bpEd1rHwDoKv9ZH8UejjECwtsbVfKzU
         cjpAlNfJoOJPbJCnXGG9rMOlA8EBRiQsQ1hOOV1MT4aglTXQzKfZGGzLbfFzb5TvaX4p
         M5mCqyueDpamJ/OYMsuQfD/6z1RSyrovGCi96ZSZ99RlK3WL7Q5qy4Fos9Z426QcTKNm
         rXGA==
X-Forwarded-Encrypted: i=1; AJvYcCWFc4dFuTLOm/bbTESm3nDZk0R9AK/LB1yt3FsEasNBslImreI+l3AEXWkFLWPEJNCTONpRuS61@vger.kernel.org
X-Gm-Message-State: AOJu0YygdenFIRCpxmwcrOaxHuqLLpEe7HfKLwhq0Nb3FMv0pQ47Jxe9
	KwzGn3nuH2MrkJ4oJWb7/0AdWf2imFMCbUNVCwKvSfwMXlNxEOsLx42MZ7hMsBAE+j0=
X-Gm-Gg: ATEYQzyqdlqDXgbpay+PdMYVqPOq1WZYWkn60qy7eEO5XKQxZaCx8rYcvz6jK+E7Km9
	aTTQWBwVZdWIuGosNXkA04xIkwo7DZAAsyzRUemXlg6Y4k0FIfvd+WwU0zxI3h2hJtFP3dTET0q
	o6rfw4noDlBBny5ss9S4/eF0Gswds86XwgCDwCcyt3fUf+PpQHB1Rl8OWwJDsTZxdGtluAkCtrS
	egJGBQPQwIoq4LnIJC/+guSyhgRu1rh+lSaxV50o++87nrNCsDdZ5H55P2ESO0s3z/p9txwBhX+
	s8rPr1L8/4xRFch295QQb4CXMBPRsGpeAE9HAJI3kkkGhpZIBAB+hMMaSP7eRivtkmty5wzwCH/
	NxD6iZsZkKpR/mdY0cMoJGty1eLUnDtN8n9rkBQIqI3jUJ2bjqIotLYmsrj9T8ilRlk5lwF2bcV
	iewCpjUxxeTtMts4Ri/yU4ig==
X-Received: by 2002:a05:620a:269a:b0:8cd:9b31:23b1 with SMTP id af79cd13be357-8cdb5b1b1ebmr170750085a.53.1773351726619;
        Thu, 12 Mar 2026 14:42:06 -0700 (PDT)
Received: from localhost ([2603:7000:c00:3a00:365a:60ff:fe62:ff29])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8cda2151db2sm404907185a.44.2026.03.12.14.42.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2026 14:42:05 -0700 (PDT)
Date: Thu, 12 Mar 2026 17:42:01 -0400
From: Johannes Weiner <hannes@cmpxchg.org>
To: Joshua Hahn <joshua.hahnjy@gmail.com>
Cc: Minchan Kim <minchan@kernel.org>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Yosry Ahmed <yosry.ahmed@linux.dev>,
	Nhat Pham <hoangnhat.pham@linux.dev>, Nhat Pham <nphamcs@gmail.com>,
	Chengming Zhou <chengming.zhou@linux.dev>,
	Michal Hocko <mhocko@kernel.org>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Shakeel Butt <shakeel.butt@linux.dev>,
	Muchun Song <muchun.song@linux.dev>,
	Andrew Morton <akpm@linux-foundation.org>, cgroups@vger.kernel.org,
	linux-mm@kvack.org, linux-kernel@vger.kernel.org,
	kernel-team@meta.com
Subject: Re: [PATCH 07/11] mm/zsmalloc, zswap: Handle objcg charging and
 lifetime in zsmalloc
Message-ID: <abMzKa27khxDLO_D@cmpxchg.org>
References: <20260311195153.4013476-1-joshua.hahnjy@gmail.com>
 <20260311195153.4013476-8-joshua.hahnjy@gmail.com>
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260311195153.4013476-8-joshua.hahnjy@gmail.com>
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[cmpxchg.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[cmpxchg.org:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-14793-lists,cgroups=lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,chromium.org,linux.dev,gmail.com,linux-foundation.org,vger.kernel.org,kvack.org,meta.com];
	FROM_HAS_DN(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[cmpxchg.org:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hannes@cmpxchg.org,cgroups@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[cgroups];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 8C6C927A1D6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Mar 11, 2026 at 12:51:44PM -0700, Joshua Hahn wrote:
> @@ -1244,6 +1297,8 @@ void zs_obj_write(struct zs_pool *pool, unsigned long handle,
>  	if (objcg) {
>  		WARN_ON_ONCE(!pool->memcg_aware);
>  		zspage->objcgs[obj_idx] = objcg;
> +		obj_cgroup_get(objcg);
> +		zs_charge_objcg(pool, objcg, class->size);
>  	}
>  
>  	if (!ZsHugePage(zspage))

Note that the obj_cgroup_get() reference is for the pointer, not the
charge. I think it all comes out right in the end, but it's a bit
confusing to follow and verify through the series.

IOW, it's better move that obj_cgroup_get() when you add and store
zspage->objcgs[]. If zswap stil has a reference at that point in the
series, then it's fine for there to be two separate obj_cgroup_get()
as well, with later patches deleting the zswap one when its
entry->objcg pointer disappears.

> @@ -711,10 +711,6 @@ static void zswap_entry_free(struct zswap_entry *entry)
>  	zswap_lru_del(&zswap_list_lru, entry, objcg);
>  	zs_free(entry->pool->zs_pool, entry->handle);
>  	zswap_pool_put(entry->pool);
> -	if (objcg) {
> -		obj_cgroup_uncharge_zswap(objcg, entry->length);
> -		obj_cgroup_put(objcg);
> -	}
>  	if (entry->length == PAGE_SIZE)
>  		atomic_long_dec(&zswap_stored_incompressible_pages);
>  	zswap_entry_cache_free(entry);

[ I can see that this was misleading. It was really getting a
  reference for the entry->objcg = objcg a few lines down, hitching a
  ride on that existing `if (objcg)`. ]

