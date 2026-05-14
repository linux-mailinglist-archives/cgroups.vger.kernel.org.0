Return-Path: <cgroups+bounces-15929-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SK7zN61nBWojWgIAu9opvQ
	(envelope-from <cgroups+bounces-15929-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Thu, 14 May 2026 08:11:57 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B2D253E371
	for <lists+cgroups@lfdr.de>; Thu, 14 May 2026 08:11:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 121D33034EC1
	for <lists+cgroups@lfdr.de>; Thu, 14 May 2026 06:11:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09F8E3BF662;
	Thu, 14 May 2026 06:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YARf9vuE"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F81925A2DD
	for <cgroups@vger.kernel.org>; Thu, 14 May 2026 06:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778739112; cv=pass; b=hWvTZCE0GR9gRa9cvZ9NKUO52UBfbXPutojwKEMmsZnb6Vk+M4iNDONtmY+dxeun6H4ELP2FbA6/dOJ2T2YO/EcrH2HeYAkXRhrwhqjDarkyPqJuyI44CQz3hIN9rpwmcHNYCTt6w/EJ4VUaUnhpPXZmQ0s0qmaXc5e7vE1WLlw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778739112; c=relaxed/simple;
	bh=WjBK/qp2UnvYZxZmUY67cYDedQ1kRJup84QoRzAn834=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WULMR1Op60PERAEY7FmY4F4/SuGzlnEsWGSGBEogmji5CWN+qHLqI1A0wsVGX1e4US7hOjK6sLMz+qSVCtjbbp/n14Q0/02+kRmOR6p2joCI32K0uuAl5v+cUiSdcHyt+zmVLnSjveTuhdWL1XqD+0TDjB/Izc2u8dl1zzm7k5w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YARf9vuE; arc=pass smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-6802f9c5debso6247108a12.3
        for <cgroups@vger.kernel.org>; Wed, 13 May 2026 23:11:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778739110; cv=none;
        d=google.com; s=arc-20240605;
        b=YoielwZP1cj2V81PO4hgcvs5w4ZvZmTU6v+Ra8o7oFIF280gyQhy7jXc8wpfI2yXBB
         6RsRv6NG/mbkQrfU0emCt2KzzWR73l6zKGB+IY2cT+oW5F4fKLPiPz7sRRM51XFzQBVV
         uW1+6sySdWrxb9mKEJ/02oTMPEF9z4aSha3TaCJBcV2LnFKctYG1Em+dGljha7M29FwV
         bHBYW7IDhqtULJ/pTihrBsKJUl0Awjj4swmoodDVXD1nmztlsgloVZfS0WEXqXRlUqwe
         GHfzpX6s0Bs78kKhhTscmOC3/g+BGrtPkklRLuOUah3YwbRmUmP+yGYFUncTnz5AwypI
         lzaA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=G5REFkVRQP1PgZhQ8Dd1IAxYTmrHpN93ck9+DTARhFc=;
        fh=HRJsOxgsoUr+oskUxgfhTu9HZDgcR2W9hJnTA92Gb2c=;
        b=hYRvNmTFpq/mch4vrvXkBT+aiQalEhOLkmj5M1flWxAYuO8ArHaTwOUpDXwfZTjwOE
         ceS83Wkwi/1A0UphXYJfr/qKlLVo1fTvX4BHcXEQLfbGUFh9V5oTIHdns19ySp3d+KxD
         K4wi9vDcORum2AZMfigXXcH3xm2gudTROD9Xfi+opZ/EnUn6KCHAmA1x3ws8MAGxvx7K
         P/1ZNZKNdXPsvb3E7pWApQFlZmOqPwNUmOiQpbWVaEMddNTVt0R7WKiuogIuNTKD5Hof
         yxOrq14i7vd0hmLEsm9KgrD8tqqmAsJJirKuou4ZMI4zPb9tfjRnJn6akaGW/2zhD+4Z
         eIqw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778739110; x=1779343910; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G5REFkVRQP1PgZhQ8Dd1IAxYTmrHpN93ck9+DTARhFc=;
        b=YARf9vuEbbgumg1qaZhxNKOeM1ZhfOjwgHMdpRpGYJgCPUwKm2/e8oZcw9wmi0WcSN
         VrcldQSL4gjv/w+jZSJxBc7NUzR7e8sIkyuNCWPcKQhsKBdMIb97K6p2pU2P35o+C735
         KzvulqMtiJgpMtY+AH8+uXvWQezJQ1s/rFlnu25xl6ddFTUX8Tixp7hfYS5fiv1ZV7S5
         oJdTwneywQHWK9+zbjrlNmNiGz8IfeX32nrYDnSfRdGzyAPXTCwriU8TJmACxc3Q6+KH
         uvFIzmPgMFWaDUi8xUFGVkQ4Gqyd2leNTGQQ2jV2RxfQ9vQx0cN/muOx+TxN2PpgvI0E
         U8SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778739110; x=1779343910;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=G5REFkVRQP1PgZhQ8Dd1IAxYTmrHpN93ck9+DTARhFc=;
        b=eR86ZhTG/uGBKNgCEmrYqdgXAMf3CqhYf9rvdubpnZXj86EdfW6zrXti68vzI9e0Vm
         Jr+64gK5/iylXM/MQGnPRti42JBtIzbcXYOO7v+H5OBYo1TpNDx5UgHXXpZhQYGqHzoE
         r75M+emxnOb9mboEpE69uCA1Dw/OLl2Ptyb5eVhFRaUc7OxrymRa8xPgt+SCDr0z61Xq
         IXW58phVZ1ShxkkhA/YRCHFQX4zNw2mUgH+vtJQCEVMEZ3agkBlvEb848I27XAqGMYlE
         FX9kLg3TIYCRtDy0BZVJDZwtqhFSLen8A5OU+jPZQ57fBFYiscBnHX8VjXXy6RXejp2K
         dpdA==
X-Forwarded-Encrypted: i=1; AFNElJ8k7uy0BNvmbNjI/iIFq+F+ZJvB20Tek2w2t18HunjadLfMtCxiY7Z4j2+ddwD6shGBNZa+ZJ5N@vger.kernel.org
X-Gm-Message-State: AOJu0YxmE751lrDm9PVnPTgE0oSl860nB8wEcch+ngVbv9KY/T6Uhsv+
	xmV2kiLzaaSDgxZ04vCRjcdyGWfiesZfOpnGq3Ce0TCzQFAjxChfb4HzPyRX03eOLXi6BdOgNL9
	Bno4Wy7BFmvBLC2EI96RIMqegec3wn9k=
X-Gm-Gg: Acq92OFeSAWwsdLBQi6BDe9cX6AueYaJ98jvty+XwuvZ6m2HLPPhOllKTzcWXk4zKDI
	BzztKzCsnmpcNPvHQV9Oidzw48mU0VffrTraM5rKkOvEjbsIeKBn/R+QgtbF6WeFtgc+UE73SXI
	tqMtx+YyOmHy5jHoN72dIDpQJcytuwTXZb1ZxZ2Mszyx58FMHshUEmCXLJd5i4bJiPCKm8IsjWC
	p57xGLWMZcqtMgOzqg+dA68xM08Fm5kncfNAc6QWbRu8F8IWNWXLN/xeDf/s811aOGqgvW3jGO3
	62JCii/K8BuqLzCRTe3hInjoToVwHWEarsDuVzZz
X-Received: by 2002:a05:6402:a54a:10b0:67e:2498:dc77 with SMTP id
 4fb4d7f45d1cf-682559fe2e7mr2979488a12.6.1778739109728; Wed, 13 May 2026
 23:11:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260421-swap-table-p4-v3-0-2f23759a76bc@tencent.com>
 <20260421-swap-table-p4-v3-4-2f23759a76bc@tencent.com> <agS0RbXpVMcYMI3g@yjaykim-PowerEdge-T330>
In-Reply-To: <agS0RbXpVMcYMI3g@yjaykim-PowerEdge-T330>
From: Kairui Song <ryncsn@gmail.com>
Date: Thu, 14 May 2026 14:11:13 +0800
X-Gm-Features: AVHnY4LqVf9KEtjDJXQ19-lzC1qpbt_GnAEMVZu0CXtWRcKkvRvWTO9NkXEF4dc
Message-ID: <CAMgjq7D8m6Fon0TWRwF1c5QqKso13wv41YNu5aJsR2Ggf8Y07w@mail.gmail.com>
Subject: Re: [PATCH v3 04/12] mm, swap: add support for stable large
 allocation in swap cache directly
To: YoungJun Park <youngjun.park@lge.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>, 
	David Hildenbrand <david@kernel.org>, Zi Yan <ziy@nvidia.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Barry Song <baohua@kernel.org>, 
	Hugh Dickins <hughd@google.com>, Chris Li <chrisl@kernel.org>, 
	Kemeng Shi <shikemeng@huaweicloud.com>, Nhat Pham <nphamcs@gmail.com>, 
	Baoquan He <bhe@redhat.com>, Johannes Weiner <hannes@cmpxchg.org>, 
	Chengming Zhou <chengming.zhou@linux.dev>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Muchun Song <muchun.song@linux.dev>, 
	Qi Zheng <zhengqi.arch@bytedance.com>, linux-kernel@vger.kernel.org, 
	cgroups@vger.kernel.org, Yosry Ahmed <yosry@kernel.org>, 
	Lorenzo Stoakes <ljs@kernel.org>, Dev Jain <dev.jain@arm.com>, Lance Yang <lance.yang@linux.dev>, 
	Michal Hocko <mhocko@suse.com>, Michal Hocko <mhocko@kernel.org>, 
	Suren Baghdasaryan <surenb@google.com>, Axel Rasmussen <axelrasmussen@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 4B2D253E371
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-15929-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kvack.org,linux-foundation.org,kernel.org,nvidia.com,linux.alibaba.com,google.com,huaweicloud.com,gmail.com,redhat.com,cmpxchg.org,linux.dev,bytedance.com,vger.kernel.org,arm.com,suse.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[28];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ryncsn@gmail.com,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[cgroups];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On Thu, May 14, 2026 at 1:53=E2=80=AFAM YoungJun Park <youngjun.park@lge.co=
m> wrote:
>
> On Tue, Apr 21, 2026 at 02:16:48PM +0800, Kairui Song via B4 Relay wrote:
> ...
> >  static struct folio *swap_cache_read_folio(swp_entry_t entry, gfp_t gf=
p,
> >                                          struct mempolicy *mpol, pgoff_=
t ilx,
> >                                          struct swap_iocb **plug, bool =
readahead)
> >  {
> > -     struct swap_info_struct *si =3D __swap_entry_to_info(entry);
> >       struct folio *folio;
> >
> >       /* Check the swap cache again for readahead path. */
> > @@ -594,16 +700,12 @@ static struct folio *swap_cache_read_folio(swp_en=
try_t entry, gfp_t gfp,
> >       if (folio)
> >               return folio;
> > -     /* Skip allocation for unused and bad swap slot for readahead. */
> > -     if (!swap_entry_swapped(si, entry))
> > -             return NULL;
> > -
>
> Hello Kairui
>
> With the swap_entry_swapped() check gone, the swap_cache_get_folio()
> above the do-while is now just a duplicate of the loop's first
> iteration. Might as well drop it (and the now-stale "again for readahead
> path" comment) here.

Ah, very nice observation! Thanks, will drop it.

