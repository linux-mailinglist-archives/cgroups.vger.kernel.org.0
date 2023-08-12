Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57640779C81
	for <lists+cgroups@lfdr.de>; Sat, 12 Aug 2023 04:08:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233850AbjHLCIe (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 11 Aug 2023 22:08:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233512AbjHLCId (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 11 Aug 2023 22:08:33 -0400
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C69572712
        for <cgroups@vger.kernel.org>; Fri, 11 Aug 2023 19:08:32 -0700 (PDT)
Received: by mail-qt1-x82e.google.com with SMTP id d75a77b69052e-407db3e9669so71271cf.1
        for <cgroups@vger.kernel.org>; Fri, 11 Aug 2023 19:08:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1691806112; x=1692410912;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=prshbHi/RKP0L2cqyUY4iqu/u7CuqG4ghac599t9a+c=;
        b=ReRx55kHOx8AyhNaCNICBO3aB+8MDPDoP1bHhZkVlrgxynlOIcCOUhQLwCn8BDNYw3
         0Of4nqaCvFFX3F9rwMrq/poL70+DBi+ykgx6RuCSdq3EjKthBBGVHNqfNjwWYSiv+1Tm
         qM/zSvWaQg+U7H6Ln56hYIedt/nmux/3RJNo1V3dI2YA7SqezrOIdhIRDftNhBjkSSZ4
         UqwMWgmQVLAuevHN83O6259kWMIvzy5lvJqosQDVH3JxJ/rEPkCzbwCaPV47rX/TTX97
         glAcCit60db6/4eMR1hdiWSeq05x2fPt9Hg4Y46oEShGuTdMYhUeSHcV4dpLtBd+aeiB
         IgFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691806112; x=1692410912;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=prshbHi/RKP0L2cqyUY4iqu/u7CuqG4ghac599t9a+c=;
        b=Lvzx4humTJWPyrulYrqNAyxTLS1oKRFntL7whUFBolntHE3kSu0M1TDJC2h0nviQA+
         4a5ujyqxWuu68mVEmmCu/nCjmD8Y8u/TaLCfjG/RbzR+zGd7K3QVHxQ7ah2TmXBdPon1
         iqZkkNuvNFogbUOxsjUl9uT5CpTLxzzgiY29XoA/fbFmm7O5o2sTvQQkKzTbw09QxBlI
         L1rzmkJ+bcUIV6IIBXHGFgKwV7HABIWhFqtSjjimO5AkxljMHYijKj88uFzr7b+uCQGy
         3IJDvCLQJDKBWhp5Sh1GUwBySHKrLCN308x6TxftXHtKnz88pLjihyNfPgvJg381BAtb
         J4DQ==
X-Gm-Message-State: AOJu0YyXWpmhDHL8fgscBSCpmCnJSc2XE0BDA9qo28pOsNeeRGHnXNFY
        qOogP7yYa6k/+EC7tjDRGfC7k9GvveSP5p9czT1qnA==
X-Google-Smtp-Source: AGHT+IGX9aVhjmpXJJcOeTbT9pwlGZqrofrRnt201v/DrM8T+Jl0F70/8TTLrQ0LeBcx7Zdi7EpR/odhRDToR251TIU=
X-Received: by 2002:ac8:5841:0:b0:3f8:e0a:3e66 with SMTP id
 h1-20020ac85841000000b003f80e0a3e66mr328551qth.3.1691806111827; Fri, 11 Aug
 2023 19:08:31 -0700 (PDT)
MIME-Version: 1.0
References: <20230809045810.1659356-1-yosryahmed@google.com>
 <ZNNTgZVPZipTL/UM@dhcp22.suse.cz> <CAJD7tkYhxbd2e+4HMZVKUfD4cx6oDauna3vLmttNPLCmFNtpgA@mail.gmail.com>
 <ZNONgeoytpkchHga@dhcp22.suse.cz> <CAJD7tkb9C77UUxAykw_uMQvkzGyaZOZhM0nwWn_kcPjV0umyuA@mail.gmail.com>
 <ZNOVS0Smp2PHUIuq@dhcp22.suse.cz> <CAJD7tkZFxbjas=VfhYSGU84Y5vyjuqHqGsRjiDEOSDWh2BxNAg@mail.gmail.com>
 <ZNYnx9NqwSsXKhX3@dhcp22.suse.cz> <CAJD7tkbJ1fnMDudtsS2xubKn0RTWz7t0Hem=PSRQQp3sGf-iOw@mail.gmail.com>
 <ZNaLGVUtPu7Ua/jL@dhcp22.suse.cz> <CAJD7tkbF1tNi8v0W4Mnqs0rzpRBshOFepxFTa1SiSvmBEBUEvw@mail.gmail.com>
In-Reply-To: <CAJD7tkbF1tNi8v0W4Mnqs0rzpRBshOFepxFTa1SiSvmBEBUEvw@mail.gmail.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Fri, 11 Aug 2023 19:08:19 -0700
Message-ID: <CALvZod55S3XeK-MquTq0mDuipq8j0vFymQeX_XnPb_HuPK+oGQ@mail.gmail.com>
Subject: Re: [PATCH] mm: memcg: provide accurate stats for userspace reads
To:     Yosry Ahmed <yosryahmed@google.com>
Cc:     Michal Hocko <mhocko@suse.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Andrew Morton <akpm@linux-foundation.org>,
        Muchun Song <muchun.song@linux.dev>, cgroups@vger.kernel.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hi all,

(sorry for late response as I was away)

On Fri, Aug 11, 2023 at 1:40=E2=80=AFPM Yosry Ahmed <yosryahmed@google.com>=
 wrote:
>
[...]
> > > >
> > > > Last note, for /proc/vmstat we have /proc/sys/vm/stat_refresh to tr=
igger
> > > > an explicit refresh. For those users who really need more accurate
> > > > numbers we might consider interface like that. Or allow to write to=
 stat
> > > > file and do that in the write handler.
> > >
> > > This wouldn't be my first option, but if that's the only way to get
> > > accurate stats I'll take it.
> >
> > To be honest, this would be my preferable option because of 2 reasons.
> > a) we do not want to guarantee to much on the precision front because
> > that would just makes maintainability much more harder with different
> > people having a different opinion of how much precision is enough and b=
)
> > it makes the more rare (need precise) case the special case rather than
> > the default.
>
> How about we go with the proposed approach in this patch (or the mutex
> approach as it's much cleaner), and if someone complains about slow
> reads we revert the change and introduce the refresh API? We might
> just get away with making all reads accurate and avoid the hassle of
> updating some userspace readers to do write-then-read. We don't know
> for sure that something will regress.
>
> What do you think?

Actually I am with Michal on this one. As I see multiple regression
reports for reading the stats, I am inclined towards rate limiting the
sync stats flushing from user readable interfaces (through
mem_cgroup_flush_stats_ratelimited()) and providing a separate
interface as suggested by Michal to explicitly flush the stats for
users ok with the cost. Since we flush the stats every 2 seconds, most
of the users should be fine and the users who care about accuracy can
pay for it.
