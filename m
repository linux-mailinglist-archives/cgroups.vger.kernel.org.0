Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC3622407B8
	for <lists+cgroups@lfdr.de>; Mon, 10 Aug 2020 16:41:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726514AbgHJOlX (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 10 Aug 2020 10:41:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726392AbgHJOlW (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 10 Aug 2020 10:41:22 -0400
Received: from mail-il1-x142.google.com (mail-il1-x142.google.com [IPv6:2607:f8b0:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8658DC061756;
        Mon, 10 Aug 2020 07:41:22 -0700 (PDT)
Received: by mail-il1-x142.google.com with SMTP id z17so7726926ill.6;
        Mon, 10 Aug 2020 07:41:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=AidFlRL4Ug1HXYYI29mKf2liuKC4nCVYEFXiYCfw8vA=;
        b=CnzTfUG1SpGkNdLlwHUtFMtEAs/lYxwUd5HQM1e687MC6Hx2DVg0XbIOvx3VGO/z74
         /BRzNFMM9NnDz2jGQ2eASuxPpT/aB1AR3sUY0B97X9ZHGQols8ol6MIVMfMib/g48r13
         +dOLOiywM+Fr6cEXRyNvtKTpvkt+vkdJGpS12tNiDQHg2E6/oVBCkQt5kLDzQO++FKwV
         Zwa8lmALUMlCqBfNzCEQDtTttA1A9PzbVF4AwYgmbywQm+6czKeFZ5vEr8+0JbKwwxts
         sbFCWoV2tT9H22iM4NLHNgkJvREVNYHhnlEWB8Dlv9Z67SOBGa1vmez+KhDjL99Dr6uA
         yZxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=AidFlRL4Ug1HXYYI29mKf2liuKC4nCVYEFXiYCfw8vA=;
        b=joOGrU3AHTTXbE887V1t4zygaZxJCDUMf4JRiY/8hlHNaSwcSWmbvKTA+2r4pOgUwA
         kALmXK7OUx0Ovjj/q9EjcuIltsZKrBCye4JTgs+H9VvDcAF6H9O/Z1a4jwgfIYSGapYg
         TMPoaZjI/x2kWDJCLqeXpp7Saf32n86hd3TdC7q5/cC3oVhBr8+uSMkQqFza25pIkMwK
         To0CS7ZCRbZa+0DTiM23MZZ6pz6E3fyNJ0EXd/YWcNrul3w967Y4h675PSaFKGpnb+dL
         cK9wQhzWSuitRJHdcjzwiR33r7fcLPzbG6HCEVL9hrAEZi2IMdBzVBhXX8mChIgX5C3J
         KqYA==
X-Gm-Message-State: AOAM533ZAd+EgrGc/5tKgWs3eI371X/d+IMmto1a3bRRBtF6hXBZYJKa
        74MhQr7uEFB9IUmxKVEnZzpQnIsKe6rQzGwijJQ=
X-Google-Smtp-Source: ABdhPJzo3pJ+3eWBSe8FMd4AtlSqVEx0Qp8bdmYA3soM8Urzw4pi6Kq6Bjl43tvikMG3Q/MAI+I2PSwzGbulSOR3JuA=
X-Received: by 2002:a05:6e02:143:: with SMTP id j3mr16319712ilr.97.1597070481282;
 Mon, 10 Aug 2020 07:41:21 -0700 (PDT)
MIME-Version: 1.0
References: <1595681998-19193-1-git-send-email-alex.shi@linux.alibaba.com>
 <1595681998-19193-15-git-send-email-alex.shi@linux.alibaba.com>
 <CAKgT0UcbBv=QBK9ErqLKXoNLYxFz52L4fiiHy4h6zKdBs=YPOg@mail.gmail.com>
 <241ca157-104f-4f0d-7d5b-de394443788d@linux.alibaba.com> <CAKgT0UdSrarC8j+G=LYRSadcaG6yNCoCfeVpFjEiHRJb4A77-g@mail.gmail.com>
 <8dbd004e-8eba-f1ec-a5eb-5dc551978936@linux.alibaba.com>
In-Reply-To: <8dbd004e-8eba-f1ec-a5eb-5dc551978936@linux.alibaba.com>
From:   Alexander Duyck <alexander.duyck@gmail.com>
Date:   Mon, 10 Aug 2020 07:41:10 -0700
Message-ID: <CAKgT0UdK-fy+yYGLFK=YgE+maa_0_uecq0_8S_0kM8BiVgRO7g@mail.gmail.com>
Subject: Re: [PATCH v17 14/21] mm/compaction: do page isolation first in compaction
To:     Alex Shi <alex.shi@linux.alibaba.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Mel Gorman <mgorman@techsingularity.net>,
        Tejun Heo <tj@kernel.org>, Hugh Dickins <hughd@google.com>,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        Yang Shi <yang.shi@linux.alibaba.com>,
        Matthew Wilcox <willy@infradead.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        kbuild test robot <lkp@intel.com>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>, cgroups@vger.kernel.org,
        Shakeel Butt <shakeelb@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Wei Yang <richard.weiyang@gmail.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Rong Chen <rong.a.chen@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon, Aug 10, 2020 at 6:10 AM Alex Shi <alex.shi@linux.alibaba.com> wrote=
:
>
>
>
> =E5=9C=A8 2020/8/7 =E4=B8=8B=E5=8D=8810:51, Alexander Duyck =E5=86=99=E9=
=81=93:
> > I wonder if this entire section shouldn't be restructured. This is the
> > only spot I can see where we are resetting the LRU flag instead of
> > pulling the page from the LRU list with the lock held. Looking over
> > the code it seems like something like that should be possible. I am
> > not sure the LRU lock is really protecting us in either the
> > PageCompound check nor the skip bits. It seems like holding a
> > reference on the page should prevent it from switching between
> > compound or not, and the skip bits are per pageblock with the LRU bits
> > being per node/memcg which I would think implies that we could have
> > multiple LRU locks that could apply to a single skip bit.
>
> Hi Alexander,
>
> I don't find problem yet on compound or skip bit usage. Would you clarify=
 the
> issue do you concerned?
>
> Thanks!

The point I was getting at is that the LRU lock is being used to
protect these and with your changes I don't think that makes sense
anymore.

The skip bits are per-pageblock bits. With your change the LRU lock is
now per memcg first and then per node. As such I do not believe it
really provides any sort of exclusive access to the skip bits. I still
have to look into this more, but it seems like you need a lock per
either section or zone that can be used to protect those bits and deal
with this sooner rather than waiting until you have found an LRU page.
The one part that is confusing though is that the definition of the
skip bits seems to call out that they are a hint since they are not
protected by a lock, but that is exactly what has been happening here.

The point I was getting at with the PageCompound check is that instead
of needing the LRU lock you should be able to look at PageCompound as
soon as you call get_page_unless_zero() and preempt the need to set
the LRU bit again. Instead of trying to rely on the LRU lock to
guarantee that the page hasn't been merged you could just rely on the
fact that you are holding a reference to it so it isn't going to
switch between being compound or order 0 since it cannot be freed. It
spoils the idea I originally had of combining the logic for
get_page_unless_zero and TestClearPageLRU into a single function, but
the advantage is you aren't clearing the LRU flag unless you are
actually going to pull the page from the LRU list.

My main worry is that this is the one spot where we appear to be
clearing the LRU bit without ever actually pulling the page off of the
LRU list, and I am thinking we would be better served by addressing
the skip and PageCompound checks earlier rather than adding code to
set the bit again if either of those cases are encountered. This way
we don't pseudo-pin pages in the LRU if they are compound or supposed
to be skipped.

Thanks.

- Alex
