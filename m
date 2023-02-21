Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E596969E541
	for <lists+cgroups@lfdr.de>; Tue, 21 Feb 2023 17:57:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233620AbjBUQ5V (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 21 Feb 2023 11:57:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234618AbjBUQ5U (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 21 Feb 2023 11:57:20 -0500
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 311DE2CC62
        for <cgroups@vger.kernel.org>; Tue, 21 Feb 2023 08:57:11 -0800 (PST)
Received: by mail-yb1-xb2a.google.com with SMTP id e194so5575753ybf.1
        for <cgroups@vger.kernel.org>; Tue, 21 Feb 2023 08:57:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TfWrKhC0Efcbpjp7w2MXsBIaeBw0Ifz30UZjyvdXZU8=;
        b=T+TvPcrcFUKrIua4z6RQ1S+jaZ0P9bUBa/CVTFhVVu5KyCr2lY+itYJuXh8njQZOyO
         TUsUmevowwVhXmxwvkBfVYi4nDHO1oA2g+YerK6gzZS5pU2VFYt8ub8vt9ZyYGFjnrH2
         BOrqE4LH8nzrr2/mPQjW5Pi3d+T+crSDuEBRGZUqTN4t/YDHoOFMc4hU5knIy8DCk5sG
         TK/8HYz2FnR8oiJTGrdxBzlfnXICjNhWuJ+hau8wiabqlvl5Vl5+YhyfvV1gwnO33QCd
         R1ndg/MrlKjhTox2ibB+MD0EEzL2tNw4kRxtG7WhMsfdIW/GaPcCH/P/HmSKpv1fwzPM
         +lCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TfWrKhC0Efcbpjp7w2MXsBIaeBw0Ifz30UZjyvdXZU8=;
        b=NuX6J9gI5lSXW7pZagtUw0qphG849KcUvED+uBwpHPnK5t79GBG3UXhh455bpR8cvx
         fH9eGGZCJmM0dnjkpWtNr8F4qwhBtrC9nllu9Xmajig57hZaAw3LXgatyBdYoTwVOiCg
         zngsJ6XAnuCLDIZ1aCC0ti/fEAcrZ9eaivu5HsmLQN0AQrEoRO/x+8u/2btLSLt+H8L2
         gE7u/Yhn47gSc6A+j+XS83ykbo0jkXm41zMtGDsQKFmEPPA4tUkqMuNAPCaKY9QzGsTb
         kGzvC7dmtpvjUIvgGTFH+4bricuY0QF0MAS7PpsUPyNQ8RLA7U5yMkTHn0enBOIo+30R
         K0FA==
X-Gm-Message-State: AO0yUKVeWLyP5W3YwXEHdJJeSUA3MW0fn9ZjCFAztZ3WyH3e5cff2WHV
        GvxohnIF8mAXwCUfFzugLqL0YQMpJPjsul+thU/e2A==
X-Google-Smtp-Source: AK7set9A8u6VEqmytgi8+HBZJmlK4fLnoUHs+bnR0vNjMgaTc5H7RcLClklBqNhakQilr9QwcNWjLCWtW/zyQdkNp/Y=
X-Received: by 2002:a5b:691:0:b0:902:535c:8399 with SMTP id
 j17-20020a5b0691000000b00902535c8399mr191198ybq.461.1676998630231; Tue, 21
 Feb 2023 08:57:10 -0800 (PST)
MIME-Version: 1.0
References: <20230220230624.lkobqeagycx7bi7p@google.com> <6563189C-7765-4FFA-A8F2-A5CC4860A1EF@linux.dev>
 <CALvZod55K5zbbVYptq8ud=nKVyU1xceGVf6UcambBZ3BA2TZqA@mail.gmail.com> <Y/TMYa8DrocppXRu@casper.infradead.org>
In-Reply-To: <Y/TMYa8DrocppXRu@casper.infradead.org>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Tue, 21 Feb 2023 08:56:59 -0800
Message-ID: <CALvZod6UM1E6nGgfdORri90m3ju+yYeSeHBqyqutCP2A94WNKg@mail.gmail.com>
Subject: Re: [PATCH] mm: change memcg->oom_group access with atomic operations
To:     Matthew Wilcox <willy@infradead.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Marco Elver <elver@google.com>
Cc:     Roman Gushchin <roman.gushchin@linux.dev>,
        Yue Zhao <findns94@gmail.com>, linux-mm@kvack.org,
        akpm@linux-foundation.org, hannes@cmpxchg.org, mhocko@kernel.org,
        muchun.song@linux.dev, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

+Paul & Marco

On Tue, Feb 21, 2023 at 5:51 AM Matthew Wilcox <willy@infradead.org> wrote:
>
> On Mon, Feb 20, 2023 at 10:52:10PM -0800, Shakeel Butt wrote:
> > On Mon, Feb 20, 2023 at 9:17 PM Roman Gushchin <roman.gushchin@linux.de=
v> wrote:
> > > > On Feb 20, 2023, at 3:06 PM, Shakeel Butt <shakeelb@google.com> wro=
te:
> > > >
> > > > =EF=BB=BFOn Mon, Feb 20, 2023 at 01:09:44PM -0800, Roman Gushchin w=
rote:
> > > >>> On Mon, Feb 20, 2023 at 11:16:38PM +0800, Yue Zhao wrote:
> > > >>> The knob for cgroup v2 memory controller: memory.oom.group
> > > >>> will be read and written simultaneously by user space
> > > >>> programs, thus we'd better change memcg->oom_group access
> > > >>> with atomic operations to avoid concurrency problems.
> > > >>>
> > > >>> Signed-off-by: Yue Zhao <findns94@gmail.com>
> > > >>
> > > >> Hi Yue!
> > > >>
> > > >> I'm curious, have any seen any real issues which your patch is sol=
ving?
> > > >> Can you, please, provide a bit more details.
> > > >>
> > > >
> > > > IMHO such details are not needed. oom_group is being accessed
> > > > concurrently and one of them can be a write access. At least
> > > > READ_ONCE/WRITE_ONCE is needed here.
> > >
> > > Needed for what?
> >
> > For this particular case, documenting such an access. Though I don't
> > think there are any architectures which may tear a one byte read/write
> > and merging/refetching is not an issue for this.
>
> Wouldn't a compiler be within its rights to implement a one byte store as=
:
>
>         load-word
>         modify-byte-in-word
>         store-word
>
> and if this is a lockless store to a word which has an adjacent byte also
> being modified by another CPU, one of those CPUs can lose its store?
> And WRITE_ONCE would prevent the compiler from implementing the store
> in that way.
>

Thanks Willy for pointing this out. If the compiler can really do this
then [READ|WRITE]_ONCE are required here. I always have big bad
compiler lwn article open in a tab. I couldn't map this transformation
to ones mentioned in that article. Do we have name of this one?

thanks,
Shakeel
