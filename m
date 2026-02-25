Return-Path: <cgroups+bounces-14386-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ozLrIEJsn2mObwQAu9opvQ
	(envelope-from <cgroups+bounces-14386-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 25 Feb 2026 22:40:18 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9564C19DE64
	for <lists+cgroups@lfdr.de>; Wed, 25 Feb 2026 22:40:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6EE61304CEAE
	for <lists+cgroups@lfdr.de>; Wed, 25 Feb 2026 21:40:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CEFE314B79;
	Wed, 25 Feb 2026 21:40:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GAtULty4"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8CAE265621
	for <cgroups@vger.kernel.org>; Wed, 25 Feb 2026 21:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772055613; cv=pass; b=g5BYTjqM2Zy8PpFtwwrH1YfinlqP0WWTMYPNAWKmA4Uk1p3ZocSQZINGyjrnlFGcs2irBvrndxX1uWzi6B26lp1HhuOlkH17rQWNUrJ4Te/fAlGaa7OIcpDNXnhaHncrC7mBjk86Wj0uz5fWzJxW3yk2qJY/oAeBu7f+Ie6IOnc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772055613; c=relaxed/simple;
	bh=MC48NTCQgd8S5WKSeiW9O6obPMz5m4dtdBz9OgbxJ7Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UZiILweIdZqwtK/ZnUieWE3VZis8kI6BiohOyOnXX15ElIVQ73eTEsXwsqowyaCjlJctlAvPkmIH0SNnVsB3QPkYN1Z57dZDQ5pYnYG9QOlu2oP2NP3BVf3uHdmfxHrs70ekhnjY5VwEfJvVysW4d80gskHvFN8FO6UiapV77lI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GAtULty4; arc=pass smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-899a615825fso2358356d6.3
        for <cgroups@vger.kernel.org>; Wed, 25 Feb 2026 13:40:11 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772055611; cv=none;
        d=google.com; s=arc-20240605;
        b=fErqWRAb3MEj2hoz9xfRb3ozzHDXEPcx6c+dnd38UGrFjIgcY/nWDFLTq5/jfB+OPx
         /YK1yUVdern2F5YPn+LrKvvWMhTbVnAUns90yylT2jlxiYO9SxT2GYCSem8RY0FkI508
         2v96YsKwlhwqDsuPjOZ1n/cQK7T/aQUr/54ATmQrKCelxUVUgJdELxVZHhWlmhC0KLNT
         RzO0Num5N9uCbCTVDFFiWVYMMThPOfa4LPDWYFbs7V2BXpKiWwybQ0saAl0eg1C86Dic
         x7HVIkuumVZhjUMDm9+l5fhQiyCKvYMbpaKhIxx5RLo8uyGwbf3ArRulwr41hd9BZMsL
         3jqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=MC48NTCQgd8S5WKSeiW9O6obPMz5m4dtdBz9OgbxJ7Y=;
        fh=7+bTalwJ17GBEEHSjYH5UpNXYm8Tft7l52ufFp5hIxc=;
        b=IMvlMfdwjlT6KEY6wJm+Hd2okWVKzKpxTVSo6DTUTt9KhRE2GJcWMswnzsPzTo8PRa
         AguYSXUdifvpXuOqaE0RJPqqTgWiKohXgifqsxmD5yNk6OTKj+WgQ0Q5c1RqQEfundgs
         LCeYEtZq6NL5x5gKhntj7vBiZrnZi1y083a2rkkz7cLCEYehcRbh/2g7bvtDTqV6Tzhc
         6gXBlXhZyLq+iZcFBTvbjqr26rWIb3+X7xmfII2ggv2WL9Rzb4pmr/Z8VC49VSS1RG+O
         SFLFrFG7POC+cbIyVyiEhf4r5hvJCFnI+V6fvt9GUdlGVlDIlOEXrU94anMUIC/ftWh/
         n6/A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772055611; x=1772660411; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MC48NTCQgd8S5WKSeiW9O6obPMz5m4dtdBz9OgbxJ7Y=;
        b=GAtULty47KjUlNN/WUvxHmT2jIjI8KAJTgDjNV39PEh5Jfi7gtbBiMX+a4dz4V7unm
         gPLqXxLkI8G+8kZ98aqhovC/xTcdHz2Wa6haWKEjis29FFHXfrJr9FCT7YYtXbUs02C8
         Db9JkUiFXFRarm0+0bld2mPwp6nxJ1tm+MPGmhQMwSIxMOWqBfQxw5YcB18xQrccpR89
         da0Iua3DJw11oHgIuVypl4iNLkQhQ4usTqG9PTwnNDoPFZQfccTXirfud1rdZoNLLSVj
         oy5mDs0b+mIwHSzLbS7FMquzu0+k3S5JS648qoWICjQ9Wuq0XmckE1b6u/Tj4gYxCaJ2
         oc7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772055611; x=1772660411;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=MC48NTCQgd8S5WKSeiW9O6obPMz5m4dtdBz9OgbxJ7Y=;
        b=ESULruy8N9N3O2CiMSmF58f4J4exnh9zNtTEIZ/MPF0YLa8d6Lw9r5qHT2bN9Vq7Jc
         W9D8VuM1992kvLWIGUXoMkRGG+Gu1SGOKGr8C7qYEpBsbME9dJyQWE3PPfpJgdxSfHSg
         no9v7Rw10QM9uvsTGitT1+NwTE2oFvae7xN2Gmpoj8SkNphEmmRaJLOrsvtzD6L71DLw
         x5rSzRWju0TrmRJhVWS5Ed+npnjLM+X4vFCdHqvgTdS5qE/bP2l/uZgmdMwfUbYd2tX+
         DDsxWUwMI/+R7RL05xPjTHFoBEnYFsRqlz9dSI3f7XnhVUKJGv03juST7XzdPBsxlAa0
         D4AA==
X-Forwarded-Encrypted: i=1; AJvYcCW5CJZery146/pK9TWp34kBJ0+kZ1rh88SHaw1N9SLFOrK6el8uOlxy13OMfazhv9g5hNzlqLQe@vger.kernel.org
X-Gm-Message-State: AOJu0YzgEzbnIQjptAf7bcnWy+n75XU/0VV1WUrDwWFgK1qZbuhTKM5n
	O9ENBhdrTW76tNnDDW31efYO5LoFcG1yUkS73rDsBvvRDTmAJaprZSxlDO4hhDRBjZg9H3tfshF
	FpN8EXxajDwtKFOJr4F523Npj2oh7X2k=
X-Gm-Gg: ATEYQzzmDFVRLTgVzbQYfYY7W8gG5bniXg46FzW5kw3PppuQGPi4Mc0bjRVgfOaq4Gu
	Tvi3HskLEwkwxSoagUqOzLaKYvDJvo2TfgyCSMrUGVmb05PzydF8JpYzRssMIJZEqYW0ARehNpP
	SuX9OM12yPAJKCLr947QIFKWhTUJQc7tOISR2RlRu66+KeyyKWaebC791DClzSp6f6D8K1R6qa9
	rECIYWE5PuAKSK2Wlb2gLUFoHv1Y0R45hXj9G0DKGP2ftdIhO+VwVN0xPj07qgmdvKAAeC6sGgx
	gq9MRA==
X-Received: by 2002:a05:6214:5099:b0:896:a692:cabd with SMTP id
 6a1803df08f44-89979eebfe2mr227932696d6.45.1772055610641; Wed, 25 Feb 2026
 13:40:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260220-swap-table-p4-v1-0-104795d19815@tencent.com>
 <20260220-swap-table-p4-v1-12-104795d19815@tencent.com> <CAGsJ_4yv31utMTsZcRf5adeUzC7NnE0DfMKRFi3v1iCxfdXbdw@mail.gmail.com>
 <CAMgjq7AMOuLYRX_A-y8aUuQq-yTPhvj05QbNrLWDQgy+H9MsNA@mail.gmail.com>
In-Reply-To: <CAMgjq7AMOuLYRX_A-y8aUuQq-yTPhvj05QbNrLWDQgy+H9MsNA@mail.gmail.com>
From: Barry Song <21cnbao@gmail.com>
Date: Thu, 26 Feb 2026 05:39:59 +0800
X-Gm-Features: AaiRm52x6mqjE0fz0V4-TeY8fmvMuu0CP0XhSo9jwKMgvmqkoqrAkEWcRBaXjRE
Message-ID: <CAGsJ_4zg_C3YbOLduC5dEb-0Ozm033d-KGK7E1Uv5n6NbjGokQ@mail.gmail.com>
Subject: Re: [PATCH RFC 12/15] mm, swap: merge zeromap into swap table
To: Kairui Song <ryncsn@gmail.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>, 
	David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Zi Yan <ziy@nvidia.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Hugh Dickins <hughd@google.com>, 
	Chris Li <chrisl@kernel.org>, Kemeng Shi <shikemeng@huaweicloud.com>, 
	Nhat Pham <nphamcs@gmail.com>, Baoquan He <bhe@redhat.com>, Johannes Weiner <hannes@cmpxchg.org>, 
	Yosry Ahmed <yosry.ahmed@linux.dev>, Youngjun Park <youngjun.park@lge.com>, 
	Chengming Zhou <chengming.zhou@linux.dev>, Roman Gushchin <roman.gushchin@linux.dev>, 
	Shakeel Butt <shakeel.butt@linux.dev>, Muchun Song <muchun.song@linux.dev>, 
	Qi Zheng <zhengqi.arch@bytedance.com>, linux-kernel@vger.kernel.org, 
	cgroups@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-14386-lists,cgroups=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[22];
	FREEMAIL_CC(0.00)[kvack.org,linux-foundation.org,kernel.org,oracle.com,nvidia.com,linux.alibaba.com,google.com,huaweicloud.com,gmail.com,redhat.com,cmpxchg.org,linux.dev,lge.com,bytedance.com,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[21cnbao@gmail.com,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[cgroups];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 9564C19DE64
X-Rspamd-Action: no action

On Wed, Feb 25, 2026 at 8:34=E2=80=AFPM Kairui Song <ryncsn@gmail.com> wrot=
e:
>
> On Wed, Feb 25, 2026 at 8:19=E2=80=AFPM Barry Song <21cnbao@gmail.com> wr=
ote:
> >
> > On Fri, Feb 20, 2026 at 7:42=E2=80=AFAM Kairui Song via B4 Relay
> > <devnull+kasong.tencent.com@kernel.org> wrote:
> > >
> > > From: Kairui Song <kasong@tencent.com>
> > >
> > > By reserving one bit for the counting part, we can easily merge the
> > > zeromap into the swap table.
> >
> >
> > Hi Kairui,
> >
> > I know you're saving space by removing the zeromap memory,
> > but do you think a bitmap can sometimes be faster
> > than iterating over multiple data points to set or get bits?
> > Or is the performance difference too small to notice?
> >
> > Thanks
> > Barry
> >
>
> Hi Barry,
>
> It might be even faster this way. Swap table / swap cache is the same
> core data and must be touched upon swapout / swapin, if the bit is
> also in the swap table, then it could save a cache miss.
> Also slightly reduce memory pressure.
>
> For swapin, __swap_cache_check_batch now checks the bit with things
> like memcg info in the same place, and everyinfo is in the swap table.
> Currently it uses two loops in this RFC version but can be merged into
> one loop. Even with two loops it should be more cache friendly.
>
> And "clear_bit(offset + i, si->zeromap)" is just gone, because
> setting the NULL entry also clears the bit.
>
> Page io accesses the bit in the swap table separately, but the timing
> is close to swap table update so probably it's also beneficial to the
> cache.
>
> So I think it might be even faster, or at least the performance
> difference is too trivial to notice, I did some tests, and didn't
> observe any difference.

I did notice that some cache data has been consolidated from two
places=E2=80=94the swap table and the zeromap=E2=80=94into a single locatio=
n.
However, swap_zeromap_batch() previously operated on a bitmap,
whereas it now accesses multiple data. Is that also
expected to be fine?

Thanks
Barry

