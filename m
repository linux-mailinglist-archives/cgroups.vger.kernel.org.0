Return-Path: <cgroups+bounces-4866-lists+cgroups=lfdr.de@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7716C9770CC
	for <lists+cgroups@lfdr.de>; Thu, 12 Sep 2024 20:28:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B0D628B3D3
	for <lists+cgroups@lfdr.de>; Thu, 12 Sep 2024 18:28:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAE0B1C2331;
	Thu, 12 Sep 2024 18:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lutdFXnC"
X-Original-To: cgroups@vger.kernel.org
Received: from mail-oo1-f45.google.com (mail-oo1-f45.google.com [209.85.161.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 391231C232D;
	Thu, 12 Sep 2024 18:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726165512; cv=none; b=WfhcMFiJhi/zoLqDhzMy9XXmeg6FwIeMnJiLnV314j7RkUGQPxh6laIddcS5mAMuiiag3I7e7JHF2MCuslAKWV2naq/m3CW2pyIilaKb0vg2OjC93lQaxpMvS96gFLhMkX0L+XFTPhtxNM3W5hF8kbBUKpvZjrl/E6dPX2hedk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726165512; c=relaxed/simple;
	bh=jVd9hTU+tTo4IQnI6aBD225bmU0kWr+KD0+mSTh8xH0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UUp/Ym94yN1BkgcldN6EoE431p3c1mxZU6tYs09AWISc8WZM2I+QPU8pS8JqZ37w8RGxMxt122CwMWXGZV0f+4hLh7zvYivIlnr5BLX1xCmavvDWCACRoRLHT/EL1pyFXaeBNrdzdJrhpeuRHaAgGbu4+0/BbNv5BXSvNPPM5fo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lutdFXnC; arc=none smtp.client-ip=209.85.161.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-5e19b16568cso46632eaf.3;
        Thu, 12 Sep 2024 11:25:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726165510; x=1726770310; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b02XjPec5tCJcHnp3AtruWaD0f5QC1gXUlOd8uxHCeY=;
        b=lutdFXnCNIlW3sW5Y/xXDJke6EjTOOIaGB4PU0y9VQOAxC7P+iHI/fjHKC/EhLeQzk
         B65svPZ9FibEGzXgAOcjjGtngvn3GBuUbTPugEEkKVif96QpQjUJ51ph8rHEDdLrZ75p
         mLdKb58SQ+dLZCUpyTXz5DTa6rfHRZY226gPzWDp1oijld5RkkJjq83ItWe2+0Yp258f
         fRCvmjdscatdhC2bMMbn2uZHbd9bQzZu6Di1lOCy7JOO5a9wme+YD+Io2LdqaUZZifWN
         j2oF7OGi9LdhJy5+IvZKcuCgFJsLLNj98QHVaPAdmK9+xkG4ssrC4lTO3OXIYW0SC7u+
         Tchg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726165510; x=1726770310;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b02XjPec5tCJcHnp3AtruWaD0f5QC1gXUlOd8uxHCeY=;
        b=IlKNnZ5SOf1RwK3CrO3VfSsjGKG2gLl2qDDTPvxjfxEe7hqn1AxDo+5lY/iVjPNcWt
         uDm2XIAKi1V2z1UNMP7K1dd9qoUndI8et/DuHVGnukOQd3KU18348brFPATfdVn+i0W+
         qZUbrrxLGcTsrZHFKR7nH4SSV62ibfuGw3Mgs5H7MS1pje56wCCnInr9VkFC8rNtox3O
         FOTsf0gfkbl+lWOKC8yF3sX1w4/P3sNfD0Q09BhdzpRi/UglnUxjIpmxpBtu8Fh+Dco7
         Dcrj3kuIyzoR41tOoknnaGGXX3c/Guod1XtvjDRxSWfL7YX6dXONRMt1IDkOvcVgpBJ4
         WCCw==
X-Forwarded-Encrypted: i=1; AJvYcCWjj7fATUDOivGK5tqPNDhy4W6QcBDWuJxPnyBVDTn99aHv8LuNQEuuSbmgUQ6ekhxGzC4hLRYyo8CcmLf5@vger.kernel.org, AJvYcCXkD8+MBAkm4F6j3sSmXjqzlyISwwPgsfFkR5W+ZcrWtLCzgEuIB2qJF85kY9Ph4gqRWSYUZnrb@vger.kernel.org
X-Gm-Message-State: AOJu0Yyp+ga4NITJqUQoSK5rN0y8DCtXu2Mcfud/Mk2XXIEpZW8sDF1q
	ZMLYVB9gVg9NaIGGGEvFJEOBsfonk8EPTVelG8TExh7OCqw3RSv8215I2ck0SuKY0ZgncZ1m6Di
	VgnXcXDmOkOjgh+0CMJ4d2lg2Y8s=
X-Google-Smtp-Source: AGHT+IFH8ql+MLyyOOQSThGtbnUb/CeABolkIrQuSzx3A3cBj6WodG1ullF4+rC5DNHCvcP+wTAztJXpjqnffERLl5I=
X-Received: by 2002:a05:6358:71c9:b0:1b1:a8fb:4600 with SMTP id
 e5c5f4694b2df-1bc3966ac5cmr38751155d.19.1726165509894; Thu, 12 Sep 2024
 11:25:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: cgroups@vger.kernel.org
List-Id: <cgroups.vger.kernel.org>
List-Subscribe: <mailto:cgroups+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:cgroups+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <172547884995.206112.808619042206173396.stgit@firesoul>
 <CAJD7tkak0yZNh+ZQ0FRJhmHPmC5YmccV4Cs+ZOk9DCp4s1ECCA@mail.gmail.com>
 <f957dbe3-d669-40b7-8b90-08fa40a3c23d@kernel.org> <CAJD7tkYv8oDsPkVrUkmBrUxB02nEi-Suf=arsd5g4gM7tP2KxA@mail.gmail.com>
 <afa40214-0196-4ade-9c10-cd78d0588c02@kernel.org> <CAJD7tkZ3-BrnMoEQAu_gfS-zfFMAu4SeFvGFj1pNiZwGdtrmwQ@mail.gmail.com>
 <84e09f0c-10d7-4648-b243-32f18974e417@kernel.org> <CAJD7tkYY5sipMU+w8ygPTGKfjvdMh_e0=FtxYkO9BG5VpF+QUA@mail.gmail.com>
 <CAKEwX=PTA0OxisvY12Wa95s5KqzvQTXe1rZ7nw29nP+wR2dxkA@mail.gmail.com> <CAJD7tkbMph337XbBTbWfF8kp_fStP3-rN77vfR5tcn2+wYfJPQ@mail.gmail.com>
In-Reply-To: <CAJD7tkbMph337XbBTbWfF8kp_fStP3-rN77vfR5tcn2+wYfJPQ@mail.gmail.com>
From: Nhat Pham <nphamcs@gmail.com>
Date: Thu, 12 Sep 2024 11:24:59 -0700
Message-ID: <CAKEwX=PcK=kJG-yxaoTYvJGNwQ=eTGo1m=ZraqYy1SyLDs9Asw@mail.gmail.com>
Subject: Re: [PATCH V10] cgroup/rstat: Avoid flushing if there is an ongoing
 root flush
To: Yosry Ahmed <yosryahmed@google.com>
Cc: Jesper Dangaard Brouer <hawk@kernel.org>, tj@kernel.org, cgroups@vger.kernel.org, 
	shakeel.butt@linux.dev, hannes@cmpxchg.org, lizefan.x@bytedance.com, 
	longman@redhat.com, kernel-team@cloudflare.com, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, mfleming@cloudflare.com, 
	joshua.hahnjy@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 12, 2024 at 10:28=E2=80=AFAM Yosry Ahmed <yosryahmed@google.com=
> wrote:
>
> >
> > I'm not, but Joshua from my team is working on it :)
>
> Great, thanks for letting me know!

FWIW, I think the zswap_shrinker_count() path is fairly trivial to
take care of :)  We only need the stats itself, and you don't even
need any tree traversal tbh - technically it is most accurate to track
zswap memory usage of the memcg itself - one atomic counter per
zswap_lruvec_struct should suffice.

obj_cgroup_may_zswap() could be more troublesome - we need the entire
subtree data to make the decision, at each level :) How about this:

1. Add a per-memcg counter to track zswap memory usage.

2. At obj_cgroup_may_zswap() time, the logic is unchanged - we
traverse the tree from current memcg to root memcg, grabbing the
memcg's counter and check for usage.

3. At obj_cgroup_charge_zswap() time, we have to perform another
upward traversal again, to increment the counters. Would this be too
expensive?

We still need the whole obj_cgroup charging spiel, for memory usage
purposes, but this should allow us to remove the MEMCG_ZSWAP_B.
Similarly, another set of counters can be introduced to remove
MEMCG_ZSWAPPED...

Yosry, Joshua, how do you feel about this design? Step 3 is the part
where I'm least certain about, but it's the only way I can think of
that would avoid any flushing action. You have to pay the price of
stat updates at *some* point :)

