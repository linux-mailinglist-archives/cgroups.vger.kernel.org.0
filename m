Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00C97453C86
	for <lists+cgroups@lfdr.de>; Wed, 17 Nov 2021 00:05:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229986AbhKPXHz (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 16 Nov 2021 18:07:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229899AbhKPXHz (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 16 Nov 2021 18:07:55 -0500
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE1F4C061570
        for <cgroups@vger.kernel.org>; Tue, 16 Nov 2021 15:04:57 -0800 (PST)
Received: by mail-io1-xd2a.google.com with SMTP id y16so643805ioc.8
        for <cgroups@vger.kernel.org>; Tue, 16 Nov 2021 15:04:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NCLmpq3O2WgfnqHHONPo5k+Xb63HO8UeUsJwn/lUkKw=;
        b=S/WK2x3jIwCL9hw45soRVak8siXKxbKoVIkWsbVqHbuyFEp71jYSmrLDup+9cDXA8p
         DjebcwbV7B+z1OQ5GTfuFq30luZF4jPlC7TxDzMar1i3ioWHKlo9SS++CP0LsH1D0W0q
         KM5WdHzQfWRN7RiByjFOkn+OH+oSd8Nn0Qq/quRPXged8Oe4xORjDRUfuOCqNigM73RW
         AGiit48kQXh4fWFTik4ITYJbOXGMmL9I0ALedzjrWNNXD/d3V3u2cIEKuomhXNy5E7sQ
         ZXjsBH66ms5a3MjGWKjF0cjq3xp1/d7qUG/esLryx1CXCLPPc9sRLoHIYnW1QFYoqSQC
         xGhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NCLmpq3O2WgfnqHHONPo5k+Xb63HO8UeUsJwn/lUkKw=;
        b=2AysEkyI7jtskM9L/TZpFUraiCRY92W0GINZq4v3dUiu3hGuXfAdaNGjt/0TwhG1Li
         FeB1Yon+rEEMsTuSp98B8W/TYefEkBYglP4XP9yZdRWJ9CJi5hYa/XajuAtCXdpv+xjn
         VI4RaauMoGs7DzmfR9q7TsFIZuBk6ZdZfw0YYG/OtgAcb3Jtrayt/hn4SfW9oZzGiSeO
         mdoiv2rvhNQxkRXsQHtxN1zFxTffdRIRBygf8YcGe5Eo6LFYWKwKzkEtV3z84n1a//B2
         44Iqhn1vX2D8D2yRpYaY+00cAlImsQ3aaBlh+iIVGyxx5sg5ug5VGMQhVYUhmquLEE3F
         sneQ==
X-Gm-Message-State: AOAM531HmE6suB1JzrjMgwtzjQsCK0OMdXIoVp23ffF9Be6Itv3nz+vv
        5dGjcXY9tGp+GZtPVllJ64gmMS87H0UEdLYH8ag=
X-Google-Smtp-Source: ABdhPJwVMI7JTRNWcLvXE98fRZ3Aga2ksPqrrspXmB8zz7PbHqunR4F4o2TEgHPoEf4ywMtUIYB11vP4o0CnbXa5yCw=
X-Received: by 2002:a02:b813:: with SMTP id o19mr8818638jam.130.1637103897457;
 Tue, 16 Nov 2021 15:04:57 -0800 (PST)
MIME-Version: 1.0
References: <20211116001628.24216-1-vbabka@suse.cz> <20211116001628.24216-22-vbabka@suse.cz>
 <CA+fCnZd_39cEvP+ktfxSrYAj6xdM02X6C0CxA5rLauaMhs2mxQ@mail.gmail.com> <6866ad09-f765-0e8b-4821-8dbdc6d0f24e@suse.cz>
In-Reply-To: <6866ad09-f765-0e8b-4821-8dbdc6d0f24e@suse.cz>
From:   Andrey Konovalov <andreyknvl@gmail.com>
Date:   Wed, 17 Nov 2021 00:04:46 +0100
Message-ID: <CA+fCnZcwti=hiPznPoMNWR-hvEOQbQRjEcDgnGbX+cb=kFa6sA@mail.gmail.com>
Subject: Re: [RFC PATCH 21/32] mm: Convert struct page to struct slab in
 functions used by other subsystems
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Christoph Lameter <cl@linux.com>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Pekka Enberg <penberg@kernel.org>,
        Julia Lawall <julia.lawall@inria.fr>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Marco Elver <elver@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        kasan-dev <kasan-dev@googlegroups.com>, cgroups@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Nov 16, 2021 at 5:33 PM Vlastimil Babka <vbabka@suse.cz> wrote:
>
> On 11/16/21 15:02, Andrey Konovalov wrote:
> >> --- a/mm/kasan/report.c
> >> +++ b/mm/kasan/report.c
> >> @@ -249,7 +249,7 @@ static void print_address_description(void *addr, u8 tag)
> >>
> >>         if (page && PageSlab(page)) {
> >>                 struct kmem_cache *cache = page->slab_cache;
> >> -               void *object = nearest_obj(cache, page, addr);
> >> +               void *object = nearest_obj(cache, page_slab(page),      addr);
> >
> > The tab before addr should be a space. checkpatch should probably report this.
>
> Good catch, thanks. Note the tab is there already before this patch, it just
> happened to appear identical to a single space before.

Ah, indeed. Free free to keep this as is to not pollute the patch. Thanks!
