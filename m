Return-Path: <cgroups+bounces-14362-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4BNmD7vsnmk/XwQAu9opvQ
	(envelope-from <cgroups+bounces-14362-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Wed, 25 Feb 2026 13:36:11 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B3E56197738
	for <lists+cgroups@lfdr.de>; Wed, 25 Feb 2026 13:36:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 74F78303F57D
	for <lists+cgroups@lfdr.de>; Wed, 25 Feb 2026 12:34:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF7553B5319;
	Wed, 25 Feb 2026 12:34:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NlhK0xWz"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60A9E3B5309
	for <cgroups@vger.kernel.org>; Wed, 25 Feb 2026 12:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772022861; cv=pass; b=YTTbLAonxuKaAlxOiZfo25/C5bLy1SdKtD8+2CN9A7FBfSREjN9Z9DS1lhyrTWTvJCug2v3yzuFK9+7ILPu4m6qCbZ/fZWUpkltzNeEoLojqLbU66+bKTLphRmunz2GCmzn05q5u28sAVuY7T6dPd9eFpagTnijQndsyAdKSuzk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772022861; c=relaxed/simple;
	bh=25QvE3/rgXl+aQFhryydLx1P5GAQJfl/r/lT5mBwIWQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=X7N51DN2QJFde9+9zR2GALVpP+JwOO5QdGTDZhwd6sZCNGf1uTbu7Tv4+gpFyD5e7J7l82v+m8KjpfYHjUbZ7UkXq5I4Sl3ZO6453dbAwEOMQ171hydsVcYiiuCGOISG0zUao/8i9RGxVHVlVzSu0aYL6+hOW6zvCrRRCHrVtnA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NlhK0xWz; arc=pass smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-b9347d8dd90so54607166b.3
        for <cgroups@vger.kernel.org>; Wed, 25 Feb 2026 04:34:17 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772022855; cv=none;
        d=google.com; s=arc-20240605;
        b=a2oPv08e/hJmYhaArVIdVxkEntx02oHkHUnmHLfzZ4/jploUB1MqN0wcYTK5MAtacu
         YcbX0bVVfxYhCxgdXuEUmVi4zRbG+br2FoQJS2PBmwTGgw0d1M4CD3xMx6tUntsO07GL
         +vgmmx7Gs2g6GkV1PsJYLdKc9XBGcnzQO2I4tfAYW4lJJcODWmHiPdqJ0L5a/+6LHqB8
         yy+nKFsbuyfwRtxd4U27UUqIPh4MIIUyg35a/R/m/RhB2PLJu7XmOWvA0nL2ZU2k0/C5
         Np1M2+7foCvPV3Z72QSvs/AHIiyzd31A0Ovw8rrKMQH9mgY2hSujTDzwQjB169ATs38d
         sTBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=25QvE3/rgXl+aQFhryydLx1P5GAQJfl/r/lT5mBwIWQ=;
        fh=SE0oTyoadBWA3KKxE72nJoT7IZJmVlTBIMrBbmMA2ao=;
        b=Ebc4J64fW2DkSgV99B2YEen28AkIyb6wK2lSdPvNmaBM5kgbjNunmuP392mRg8Y+W6
         21eRc/ZVyV7Gol1QDSmLENRdZEKAiZuajR5ynLpc5/tK/H0Wz1kXbSuskEkQym2gmAok
         KQef6h1p+wrsEAN2FV/MIm8utNw8P9i7Frlf9+b5iq8oe3ToUvQIxuwudq5UlOF+dn+c
         gkX6hrz4Txuk1vEZSNX4fhqizao69Z6ccGt26j7JRgyYmK8AIgOMDFOkCZsSxGVn/tSo
         fjHPBGG/Kad7heJHGYgncn9agniLNHfToh2XHZn7GI1jjoHh8Gx7XdOn9ONfqY+029vf
         o7sg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772022855; x=1772627655; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=25QvE3/rgXl+aQFhryydLx1P5GAQJfl/r/lT5mBwIWQ=;
        b=NlhK0xWzDDWkpsR5TnLIOFbvVsddiFxe12trUxhtNwSxxJhMpiYIKKQdq2yAoyiAmW
         OOzEpapFjZ1TxRGDzksrJ3TAfVa/CwdT7fmqpd51V/tYQGNfen126DpOb9/HL4Iseuzo
         e0mwV/+KArYK2pXwI3ujJNHNf2MuCwoMYYc5Io4a0HUMagQY+9yif6yRsHfPANQoaXAf
         4XofIgEomC17HssM7zymsj5OJWiysrHzHatf1OPGyHQxLlCapA2k84qK826D8o9pd8i4
         DOmtq0SI1dXyT2Piwu93G2OJhlN3Ki8g8Cs39k1ewRMvClIOM/mFo2szSE/GWTmqb2lT
         nCfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772022855; x=1772627655;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=25QvE3/rgXl+aQFhryydLx1P5GAQJfl/r/lT5mBwIWQ=;
        b=eaVAOWWva5QyEDxvCOeU76ofDZ7rci5pkxM5BiLO9a8hLrAUAfl4X8PNi9CHya77Eo
         UZDLVne/DPsaPR6VBpLVGbeoWrqyoh9j3fUhrV52YMbSVylEq1neIpG1Q8UKQnaciS7j
         sDFz+Blis9PtMjmdD+VVnPWj11+jMxA7jNKGP312LQqmVoMpfnwzJQ9Ady9+na0xP/bH
         z7n8ihlntgzcBqIYvDUXaSTPCt1Diz9g+wG4jI2hIhyO/tusABSGI0XXhwkwLlFOTDGM
         DhJlka9uvIJ0QO+boYMOEh0qu11Q3dQd8H7mSHyWh+nXpgm5ti3wqTECwEXCYrk8hbcm
         wfQA==
X-Forwarded-Encrypted: i=1; AJvYcCX8Gj+et08lU7XpITok7UFMxtSIQVReHUAaHwYUqYfB56xw5UMtIT+atlyuu1Mux62fi939RfnA@vger.kernel.org
X-Gm-Message-State: AOJu0YwDKRXQOQ22wHZ8Cdyw+A0NkNG4t6PXunqmgvqpAAPPGOvMxLUT
	Hk9MAqg5kPg5ZTO7lKeRyGImKM3RDcIEgBWgd4XN/DyIoNFT1DS5qmsY9CL+l15k9nxM0kbAaWx
	9XNrVkJWKIuAcdxN8u2D6mvdyCniYjIQ=
X-Gm-Gg: ATEYQzw0+8fQr1OOnT6ix4GXoxPesKClbiaP0tGoO+KJn+s3HlgHFwGlgKyNBB9X6k1
	RmWXizhwQQhAqK7g7Oy/uWQv/KlcnoSlMvgZmgoWU8d0lu0548nF92/V73zYZvobesC/RjS9YGy
	8dUeOV3cuxi5mvirw2Ot0cDuCqoPibBVN0H+D32PnXNsVYAJ5Hn1YE5uXQHCspktCRPYz6JZrBW
	U2EhmDyEa4UGx5bk/PQU1bszmwTr3Lqr0pYvK7mI+t6Fb41efreEgK6P9LpqpEFe/1CS80KG5z/
	HgwxfdKNb8nMPHTKvpiJfS0mDBDOzUzBxa2Fkf9Y+GvEl0x2zxY=
X-Received: by 2002:a17:907:d2de:b0:b88:775c:bd68 with SMTP id
 a640c23a62f3a-b93517377c4mr3516366b.28.1772022855187; Wed, 25 Feb 2026
 04:34:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260220-swap-table-p4-v1-0-104795d19815@tencent.com>
 <20260220-swap-table-p4-v1-12-104795d19815@tencent.com> <CAGsJ_4yv31utMTsZcRf5adeUzC7NnE0DfMKRFi3v1iCxfdXbdw@mail.gmail.com>
In-Reply-To: <CAGsJ_4yv31utMTsZcRf5adeUzC7NnE0DfMKRFi3v1iCxfdXbdw@mail.gmail.com>
From: Kairui Song <ryncsn@gmail.com>
Date: Wed, 25 Feb 2026 20:33:36 +0800
X-Gm-Features: AaiRm52wg9w_3BfTdgSOtfcWZyY1DPjmMXW72_qSQNgpW2ho1KBhQdHip6tdXo0
Message-ID: <CAMgjq7AMOuLYRX_A-y8aUuQq-yTPhvj05QbNrLWDQgy+H9MsNA@mail.gmail.com>
Subject: Re: [PATCH RFC 12/15] mm, swap: merge zeromap into swap table
To: Barry Song <21cnbao@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-14362-lists,cgroups=lfdr.de];
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
	FROM_NEQ_ENVFROM(0.00)[ryncsn@gmail.com,cgroups@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[cgroups];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mail.gmail.com:mid,tencent.com:email]
X-Rspamd-Queue-Id: B3E56197738
X-Rspamd-Action: no action

On Wed, Feb 25, 2026 at 8:19=E2=80=AFPM Barry Song <21cnbao@gmail.com> wrot=
e:
>
> On Fri, Feb 20, 2026 at 7:42=E2=80=AFAM Kairui Song via B4 Relay
> <devnull+kasong.tencent.com@kernel.org> wrote:
> >
> > From: Kairui Song <kasong@tencent.com>
> >
> > By reserving one bit for the counting part, we can easily merge the
> > zeromap into the swap table.
>
>
> Hi Kairui,
>
> I know you're saving space by removing the zeromap memory,
> but do you think a bitmap can sometimes be faster
> than iterating over multiple data points to set or get bits?
> Or is the performance difference too small to notice?
>
> Thanks
> Barry
>

Hi Barry,

It might be even faster this way. Swap table / swap cache is the same
core data and must be touched upon swapout / swapin, if the bit is
also in the swap table, then it could save a cache miss.
Also slightly reduce memory pressure.

For swapin, __swap_cache_check_batch now checks the bit with things
like memcg info in the same place, and everyinfo is in the swap table.
Currently it uses two loops in this RFC version but can be merged into
one loop. Even with two loops it should be more cache friendly.

And "clear_bit(offset + i, si->zeromap)" is just gone, because
setting the NULL entry also clears the bit.

Page io accesses the bit in the swap table separately, but the timing
is close to swap table update so probably it's also beneficial to the
cache.

So I think it might be even faster, or at least the performance
difference is too trivial to notice, I did some tests, and didn't
observe any difference.

