Return-Path: <cgroups+bounces-14411-lists+cgroups=lfdr.de@vger.kernel.org>
Delivered-To: lists+cgroups@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yBkNAvren2kxegQAu9opvQ
	(envelope-from <cgroups+bounces-14411-lists+cgroups=lfdr.de@vger.kernel.org>)
	for <lists+cgroups@lfdr.de>; Thu, 26 Feb 2026 06:49:46 +0100
X-Original-To: lists+cgroups@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 413641A11A9
	for <lists+cgroups@lfdr.de>; Thu, 26 Feb 2026 06:49:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3BF9A306DDA3
	for <lists+cgroups@lfdr.de>; Thu, 26 Feb 2026 05:49:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9454A23A9B3;
	Thu, 26 Feb 2026 05:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X3hPYEwO"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17CF52AE68
	for <cgroups@vger.kernel.org>; Thu, 26 Feb 2026 05:49:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772084983; cv=pass; b=FGyUiCQIAlOxPRT7JEn852gRLbnJ96unk1XRaxjpJJGgg4Bf6xu/FK2ix2hJbKmU3Z8xLI4bHmj2Ori6+d6eWQF/uqc0XtBzlfET4OIpcxNIOlV3N1tETPgAaYIKx53nMTJd0mEoOb1zs136nshTmwzR5N4lXo2XVCWlbfZtTMs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772084983; c=relaxed/simple;
	bh=ClJnevY/Tv+SZ+1wV6fhjTOc+GkukA48ZkPbqBA50+o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HwUqr4R3KF5+HZ+HDMee597Xq7ictsvP/T6C1E00jQYCcGueAiKpmwuNuQz59p4x5SThAfOCvmAkJ9TgYanlgRagbOJJDWySn7RQTWYeZod9ur5Z2frDMvOrCHrqi4z3ExcKgRHXEIBsXHVuBCxG99KDQ4M062p4sQ72ih2OaI8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X3hPYEwO; arc=pass smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-b79f8f7ea43so71736366b.2
        for <cgroups@vger.kernel.org>; Wed, 25 Feb 2026 21:49:41 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1772084980; cv=none;
        d=google.com; s=arc-20240605;
        b=YqOf6MINNkaMCC3UtvB201Td95S9V6QfkZiRsRohaJyjXBvMB9Msc1VYh35XtBcTmQ
         Czz3LrhLUq7FrQfLtkYgBRndpI7o9Qra+d/+B1ljOYXici6IkiuUeJlaSh/FUZDYUM0c
         XTuH+Pw0ecSrqf2tMSZW/vacWq2KwvtcSYBWEnoBwP5+v0ZQrzMx2x0PNw5Z4LAVhbnG
         KzpiWmrdlsCY6pAFJOkvD75fqJLf0/vEzmuK+8ghFs5zVwtnQCW7022PNo56cDFlmAtH
         Wk4UCUCLGIDpDSMl1OCD9iIHBCGsQ9nt83sAQmOmS417LnL9bNvM/17QnWzZQ5noPG4H
         AJsg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ClJnevY/Tv+SZ+1wV6fhjTOc+GkukA48ZkPbqBA50+o=;
        fh=U4ECKJGIdYUa+nG2B9UrBKONMf6wOSnu80ghaqmEl8M=;
        b=HcLsPY+STaMAWBq3QGu75keaCzizPXNRZOBSeIDa1/l5RMUUHTBEHw5zaHZCKCJqmA
         ADhlbIGG3lz+SYAqZUKq0C9P7OlDf1aiLYAzQWDS42a/zqkQ5q+1wc3tk/yo9+CP2992
         VBsEXTo1wHSLWWNL7Cs88HAGfEttHl/jstPqNDGfGIeKgyquk2CBgnyNFNbsLWVrHio2
         Szmt/iN40rU7wrfbS3RolGQ6GEay+xQO6UYGXtbPClZAPPFt+EaRH6VZ82GvIB5yVJqE
         9S2cyk+YLZldVvdr93aUT307GHC4tHfe077AgBi2vNTxJ5e4R0Sp/ok2BNX2m6DB6saQ
         +9ZA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772084980; x=1772689780; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ClJnevY/Tv+SZ+1wV6fhjTOc+GkukA48ZkPbqBA50+o=;
        b=X3hPYEwOKT+37PDZszRG85gdjtvhP3OCPwuyUM0qtEmbvKrdISOfp/jQuiDqV30GAH
         qIEt64Bj3Or+SWwNHeikMqeLDb4tnkwj/akvV9G6Y4xjUeMBa9nyW3mb7JNOgyS2CG22
         0jjtVW47+lmKp9EARrRudTn+fD7zAsJy2IDZfRcjMQSLOUsXu51LFTj3feb9QUKQNi+c
         w2ZNCLYAbejYxkwVBwSCn7SCFy0LZRUEixft1vXUrPog1Ny7yLO/68ARAm7/Ia8nfisB
         beTtRE/opjPbr2ypeSPDZCLL15K2VqOTl8JXMurGjUEeXPFDA42XNPq9G+AktHaROZVO
         qaIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772084980; x=1772689780;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ClJnevY/Tv+SZ+1wV6fhjTOc+GkukA48ZkPbqBA50+o=;
        b=ua7dRd0+yj+K0QR4lW3WKyiDaiVFxRTTCLlVouB5t0lzJQtvRFTS4LPhdtef72f2zF
         9wfthBWoXRWqcU3yNlfTl87M/q8OyjbEdzfd+d0H3B3ey4IKns2V/fuTnDaiikU5iio1
         F4mz26PYUlXIXACozaVFPZoolpAm/UEo67pOTy9ShUvLLmDMgMPekl/NH2DzTHR8TLHZ
         cgJniABGjgW/80EZfnfRYU5J4KkliaGKfSbeSxK38/I1aqhY9e7J6cLJc39TaZdTBDHR
         mgeAhP+YufvReBSbwcWfpm6zVzH1IbirlOprKa+hyWxCW4GoudPHT6s/VCt1WxNn0TOj
         ntNQ==
X-Forwarded-Encrypted: i=1; AJvYcCWZ9yY8f4yTf03RwlcT/jdi4TkxS6MZ7586up0hcuZ8JXC1B3Bu+LVcNxbZnbDqSoOMOzldXBrc@vger.kernel.org
X-Gm-Message-State: AOJu0YwxL6XRK5Xek04ydb6kK1ZogSHNzZ+bULOddqzT1G3/hcXME+uK
	cKi8FoZJiq1HmweOWwzfs+0S3olZOmvfjS/rcX/RzWLPxtXMWk/hCG2noTvtZiUvwsaqZFg8bBw
	r8FXZYkUaZwv8mvDpfCnZrQSkZHDjTTM=
X-Gm-Gg: ATEYQzyflnkN4R142/YnTEtPNJWJITc/amncg87Bn8KDvhQcRZVpNhC5S2a/4BCxNpu
	gw9v2b9NyUwRDJIbJO357p+T5esshQhQxvM/cifQ1zosCtpF1jcwvC3zOPsGS2dtPs8/yFzOaVL
	ZwEo4zzP7rPtHG0hDltO+pkuwmcticWFlfqG3Wemj8jZLL0Q2HOD81i3UzLrZnHAUfvcWMmiCMb
	LKMP5xnOCcaEGvkj2JOZdMKlv3V3GJIiV2RRpvPTAd51svquDGfg1onpecU6dLfsG7lMGFHN0IW
	cSsYiaqTj3sChm9EPkAIVERyfJ2xRGlll6lVjVGy
X-Received: by 2002:a17:907:7ba8:b0:b83:95ca:589b with SMTP id
 a640c23a62f3a-b935b4b82d0mr52477966b.10.1772084980256; Wed, 25 Feb 2026
 21:49:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260220-swap-table-p4-v1-0-104795d19815@tencent.com>
 <20260220-swap-table-p4-v1-12-104795d19815@tencent.com> <CAGsJ_4yv31utMTsZcRf5adeUzC7NnE0DfMKRFi3v1iCxfdXbdw@mail.gmail.com>
 <CAMgjq7AMOuLYRX_A-y8aUuQq-yTPhvj05QbNrLWDQgy+H9MsNA@mail.gmail.com> <CAGsJ_4zg_C3YbOLduC5dEb-0Ozm033d-KGK7E1Uv5n6NbjGokQ@mail.gmail.com>
In-Reply-To: <CAGsJ_4zg_C3YbOLduC5dEb-0Ozm033d-KGK7E1Uv5n6NbjGokQ@mail.gmail.com>
From: Kairui Song <ryncsn@gmail.com>
Date: Thu, 26 Feb 2026 13:49:04 +0800
X-Gm-Features: AaiRm50fvkfk5xfVMBS285B-bWWcDT35PoKH9PJVQqUlUMG8LniXxo0EGMYL3Ck
Message-ID: <CAMgjq7BsRvdZa6VXomi6X3VjGqd=o-7=ZaE+Mrj8uXR43kBJsA@mail.gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-14411-lists,cgroups=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid]
X-Rspamd-Queue-Id: 413641A11A9
X-Rspamd-Action: no action

Barry Song <21cnbao@gmail.com> =E4=BA=8E 2026=E5=B9=B42=E6=9C=8826=E6=97=A5=
=E5=91=A8=E5=9B=9B 05:40=E5=86=99=E9=81=93=EF=BC=9A
> I did notice that some cache data has been consolidated from two
> places=E2=80=94the swap table and the zeromap=E2=80=94into a single locat=
ion.
> However, swap_zeromap_batch() previously operated on a bitmap,
> whereas it now accesses multiple data. Is that also
> expected to be fine?

Yeah, should be totally fine. The only two callers are:

__swap_cache_check_batch, right before looping the swap table as I
just mentioned and can be inlined to reduce overhead.

Another one is swap_read_folio_zeromap, also should be right after
adding the folio into swap table.

