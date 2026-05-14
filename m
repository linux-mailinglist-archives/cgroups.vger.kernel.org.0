Return-Path: <cgroups+bounces-15942-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mN0iHFWXBWp2YwIAu9opvQ
	(envelope-from <cgroups+bounces-15942-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Thu, 14 May 2026 11:35:17 +0200
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E4DD553FDA7
	for <lists+cgroups@lfdr.de>; Thu, 14 May 2026 11:35:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C6CC53029A7D
	for <lists+cgroups@lfdr.de>; Thu, 14 May 2026 09:35:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74BCA3A3832;
	Thu, 14 May 2026 09:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NU2VinyN"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CF7A3A48E0
	for <cgroups@vger.kernel.org>; Thu, 14 May 2026 09:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778751307; cv=pass; b=X9Btqypu2uiF5m8tacWja5fDGzkpZlPOBhKvQb7kJBDq8dxeSRMjX2DKe1bX0VUFD2LOHQXyThnVDhAXFY55qzjlb+rt9Fmg0Lr6CI81Ge7R3TltrPR4CPW0iM5lNnRRS4rfsF2/66KGuTPyhiJPxOhvlWYNX5PFLw20WsAgyhY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778751307; c=relaxed/simple;
	bh=fi+2Bv1yMiIZ91kIKO43jOGaRiYLjKB57Ww51GTlNQw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=h06XN4daXCE9txIC8mTetgnpuaJpe3Bl356NgIQd9Nzcd7jh1QindaXL6WP/Pz8fhxJ8UxinDqNJZwH9N1O8BMosS8wkOUtx+bCe+xYTXIPRgXCckciLU/miw6Uv2jMlrSASWthjvduUbA3yn5RZMtLOSMb5xcB84FiKvhKfXuY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NU2VinyN; arc=pass smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-67f94c078e8so7259525a12.1
        for <cgroups@vger.kernel.org>; Thu, 14 May 2026 02:35:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778751304; cv=none;
        d=google.com; s=arc-20240605;
        b=gaMcMc50V5vmUs4jHKTW+wc9vFwA/vzE6XVfvZvIFcpr6/WjFS2TP/DuM0rktNoz9y
         dHxqU8W4RxMIAV5eop+mZVOxYwlvM8Pgx9156D8nASADaQsjmlT4xpGqc/4gzDb7eDpq
         9acSF+iF2MlSNfdLw41gIvrI0Mmeg1cab56ycwlPxsLnBbEivS8TaXUCVo7nSDEJb52P
         fdM+7ismrFCW0NWeVL+WQYmER6GpKkqfUW8PaPKtSe+oz+crCH1G1jwPF/L0IGKJavqs
         xVQIgu+gLpPj3NTjpIGtA5ZVCh0+7xlZ4GbmGaHmqzLSgCP0FlsgSiitkPmHB8rQ3IMf
         lFXQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=i5BmJ+T62BckrwlUIw6kdxJ9jDEEX8iVD8QUYqwbCAA=;
        fh=emtJMOuyWPAAoYlEeo5vc91MNbIW5WVAjmEJpvLTjs4=;
        b=fK5LRoKKZ0A4+a7FH7l+qFUnPUbA+MQZrgn+LHwd5pqENWQJLzlk0ISB81+Gcrun3p
         2DIgn+tx71j+xB+HMDab3iLngjpaKKgot6w1VjURHOL4RDfo4jimWPsZCQaOOQ3RjjZD
         gi1jyvsHlKXNel62gvEKvAOBhJrVEbc2xCMaVmqM1UoF5EGl1bu4JaU+g0JTWYEbNhv2
         bfnaHDX/RI/C6fOHaVL2gFpDqeDjeFtye8gp0e/K2qd/kJ0U9mEx+Gyj8RWiK1tJjpJN
         iXEY4rdKHE5M/WLLk1VDBv0Ggq/uUC2Rgqu5oEcNROANRoTLeTmuyHXAIi0QEdGUKWfa
         xYdQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778751304; x=1779356104; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i5BmJ+T62BckrwlUIw6kdxJ9jDEEX8iVD8QUYqwbCAA=;
        b=NU2VinyNdbIiJItKNighqCId6grd3dc5c7vOlr+jsI6oRa7BvXnSlITXpUsTHfkYFd
         taatz8swoYo7JiFKCiVQvxdzPHcXs/5eylCxkxFMuQg157+jGAh4AAn91vLqiDIyUVWZ
         hR48JFkehNZ7To7JjNRwGgFhpQbbFXaYGB6An1gbaXIcP0JCXEwNR5cusYfS6dOyiGs8
         lINrSdNWjl+N9hYhXMX+nrkEDUPdp5ImPAdjgcsUuxRSLG4pMJ/J7t/Hzb/+hPXfrE+e
         DUOhO77XYOxVHHoFLPyM3MLRK3Kc3CwCjr9AlghLdcUyE7XmQ1nAqgyFcya9EIvlqqHV
         +73A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778751304; x=1779356104;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=i5BmJ+T62BckrwlUIw6kdxJ9jDEEX8iVD8QUYqwbCAA=;
        b=HFE63qXbS7lHJynqQTWNX7COaC7mTJtYZLwYi1c+M4FK2CixzpDFY0Du2MmFd2vkUn
         GFAa1bLj1gp2KV3Akg4by+zXKNvO3flcOXds6i0QiXS/eHW3ENX403c/rSJiatpa6hak
         L0UOtgJQZDnmZkQu3YRSF4rTWtJTPjTw3Q6y3UEIPZkroTFlsUHCkjgLnOjVhMtf1n67
         db5SC1aZkFtKU6VTv1OQ0JvAZ/ij4EgaUyDyB+AuTtiSBudw+P3Ufri6EcpebxxNIDIo
         5vL+V8jbpD7C3C4V3hyJfOcSQ3Uj+qdknb4mupt3JSnj0Zc30epp2MzXydikyLx9gs95
         4EuQ==
X-Forwarded-Encrypted: i=1; AFNElJ8rNHQ94t16kaADMLmxqmCaF7RgpNXvOM8COnDZ5gWhIR7Jxh/H9t4brlzBLinq65KzGDckHU3a@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1hGUdLozsG6ybul27P3+TGF4xiPYoVwTxdIVVI+CAMCo5q62y
	YwhVNRTUzo+R+DEiz7NtQGsXX+PU0lBPZsFzYSagMwMjY9mcqqGXNyG4CZowGFaKcMHcrHV31FG
	zJ+tAk2/zMCFgm7PwrB+QXhdV0/ZjZu0=
X-Gm-Gg: Acq92OF37n5k64b5Kp/Bv2MCmQJ2Zv/Sd64PKaWu+EBJlXGjtsVJCN0L3fRXYP3JEwT
	UaqyPlL2IE8Kkgy/UOmeetSt/APFWMBlBEtU1HdL/uoNZTTIVBGs1I6wmzf2SxkQby5IQMifWR4
	pbSbXkQvqzmc5yEcE00cVW8eQsUF1WYdCGfFrJFMUzRTBVPmyQbzhn9L0M8vRtuITJCxSZWF1Uq
	1ay7WT2wmYzU1g8Sul/zclvZMhsIIwmQSIFzHgL7YMsL14GRFetZHrFkmkpMuDfayGqXDXXEZiA
	fwRzq+/eZBOHlJewOQeWux3Uu52GALzhdU55yCZRcT9zX66z+WU=
X-Received: by 2002:aa7:c90b:0:b0:670:8b48:182a with SMTP id
 4fb4d7f45d1cf-682557f3d7emr3014379a12.4.1778751303585; Thu, 14 May 2026
 02:35:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260421-swap-table-p4-v3-0-2f23759a76bc@tencent.com>
 <20260421-swap-table-p4-v3-12-2f23759a76bc@tencent.com> <agTCeEuMWJtYN9EF@yjaykim-PowerEdge-T330>
In-Reply-To: <agTCeEuMWJtYN9EF@yjaykim-PowerEdge-T330>
From: Kairui Song <ryncsn@gmail.com>
Date: Thu, 14 May 2026 17:34:25 +0800
X-Gm-Features: AVHnY4LfpJtn3nb4Q3bvJ0QT35TkmRaTVD9SQDjzyukUZncbdo_xdbm0-W9qMTU
Message-ID: <CAMgjq7DjQug9JNsu2dkUoGNMn4gAurhHGTxnHfYXNjprWYxdCw@mail.gmail.com>
Subject: Re: [PATCH v3 12/12] mm, swap: merge zeromap into swap table
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
X-Rspamd-Queue-Id: E4DD553FDA7
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-15942-lists,cgroups=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kvack.org,linux-foundation.org,kernel.org,nvidia.com,linux.alibaba.com,google.com,huaweicloud.com,gmail.com,redhat.com,cmpxchg.org,linux.dev,bytedance.com,vger.kernel.org,arm.com,suse.com];
	RCPT_COUNT_TWELVE(0.00)[28];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ryncsn@gmail.com,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[cgroups];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[]
X-Rspamd-Action: no action

On Thu, May 14, 2026 at 2:33=E2=80=AFAM YoungJun Park <youngjun.park@lge.co=
m> wrote:
>
> On Tue, Apr 21, 2026 at 02:16:56PM +0800, Kairui Song via B4 Relay wrote:
>
> Nice! LGTM
>
> Reviewed-by: Youngjun Park <youngjun.park@lge.com>
>
> A few nitpicks follow. take them if you find them useful. :)

Thanks!

>
> > +static inline void __swap_table_clear_zero(struct swap_cluster_info *c=
i,
> > +                                        unsigned int ci_off)
> > +{
> > +
>
> trailing blank line.
>
> > +#if SWAP_TABLE_HAS_ZEROFLAG
> > +     unsigned long swp_tb =3D __swap_table_get(ci, ci_off);
> > +
> > +     VM_WARN_ON(!swp_tb_is_countable(swp_tb));
> > +     swp_tb &=3D ~SWP_TB_ZERO_FLAG;
> > +     __swap_table_set(ci, ci_off, swp_tb);
> > +#else
> > +     lockdep_assert_held(&ci->lock);
> > +     __clear_bit(ci_off, ci->zero_bitmap);
> > +#endif
> > +}
> ...
> > +
> >       table =3D (struct swap_table *)rcu_access_pointer(ci->table);
> >       if (!table)
> >               return;
> > @@ -470,6 +475,13 @@ static int swap_cluster_alloc_table(struct swap_cl=
uster_info *ci, gfp_t gfp)
> >       if (!ci->memcg_table)
> >               ret =3D -ENOMEM;
> >  #endif
> > +
> > +#if !SWAP_TABLE_HAS_ZEROFLAG
> > +     ci->zero_bitmap =3D bitmap_zalloc(SWAPFILE_CLUSTER, gfp);
> > +     if (!ci->zero_bitmap)
> > +             ret =3D -ENOMEM;
> > +#endif
> > +
>
> memcg_table above uses `if (!ci->memcg_table)` before
> kzalloc, but ci->zero_bitmap is assigned unconditionally.  Both
> are NULL on entry today (swap_cluster_free_table nullifies them),
> so either form works but the asymmetry reads oddly.  Either
> drop the memcg guard (with an entry VM_WARN_ON asserting both
> NULL by design), or mirror the guard here.

Good idea. Let me turn them into VM_WARN_ON. They should never be
non-NULL right now, and proceeding after a WARN shouldn't be
catastrophic.

I also notice I better let them do something like goto err_free on the
failure case, where err_free aborts early and frees everything. If any
allocation fails, the entire cluster should be freed for cleanliness
instead of proceeding. I will update this part.

