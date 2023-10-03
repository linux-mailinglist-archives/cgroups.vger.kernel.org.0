Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BEA37B6D74
	for <lists+cgroups@lfdr.de>; Tue,  3 Oct 2023 17:54:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231712AbjJCPyJ (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 3 Oct 2023 11:54:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231206AbjJCPyJ (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 3 Oct 2023 11:54:09 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 233B9A9
        for <cgroups@vger.kernel.org>; Tue,  3 Oct 2023 08:54:06 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id 4fb4d7f45d1cf-52bd9ddb741so1926050a12.0
        for <cgroups@vger.kernel.org>; Tue, 03 Oct 2023 08:54:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696348444; x=1696953244; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Dxid03xXpcvsVqUaGgfhHGeyo+iLwB2wREvZPzja/s0=;
        b=s5X5bcF5cEwHg2Yt3q4OoOnDir2XIQiefFlREGZPIJteqqnoG1xsM4L0txs5uvPNbG
         yLj97FglNRXzkhq2IerACzYEWr/wGW952knv0tgnPgXi3prUACrw/0ukzzqHpPNL4PV+
         RhRZ7HOe3VzWIEsxI+zpe4cOqFviFWV6c1FL/JQyjP5n6srYw41nCpiELh/9WGSzfm5o
         wKKp+joUPXM8juR4ni294Jpiz7J6pks4oBRV9oFjYyAHBKpnn/c8z36ZyerALiY7Jb8P
         uvehRRzTWgE9FRfZyOET94gdiWI2BCD+K/+VaflIWIgctik8DIxi6LgcRWqsndjGT4Bt
         S0Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696348444; x=1696953244;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Dxid03xXpcvsVqUaGgfhHGeyo+iLwB2wREvZPzja/s0=;
        b=U7KNzKp9ddXQy6PXNXUUPkcIhMqvu/8+j/qm81lpnpLW350XQbut5DRTyZ1a1dovFJ
         L/9xNzvh8PW45hASfTQoY4oSdFeyZHfs+o+JrN8gDeaVEt1TjQoLR/udMqP6r0Q27WeD
         nON+esohk6ckYbS1s+4T7P7NZ3z2KC5CDYx+2PbO+LSJlbX8LWNe7a782gSA+zFKaiAV
         rT3UMv3G0N9aCRkr7xD/F/g01od9kaGSAYFPQrSDnxCtKIN5gqJubwyr8MtEyc/IGtii
         VXh3QPuWNnB5nS4DKnusu6jdSDt82wa4HH7wdkaGb5f5Ad9utQrshyXquxPRtGG9kcAJ
         pqbw==
X-Gm-Message-State: AOJu0Yzrf0Mde1fkuyzeRVuEAulTvL/u4W5c+I76LiZBWXLxBKcf3sca
        4jJ/TicXPUMkCp8GiTvwOfaERdiScrBGD5g8kKpVqQ==
X-Google-Smtp-Source: AGHT+IHT5P1GPrW7t7OawdrJlX/jyBMUXSn0g82xaLa6cpdViOSy68e02n41+YU+V9/BtYsN4Pccbt9P/9A27fZ4vl8=
X-Received: by 2002:a17:906:738b:b0:9a2:86a:f9b7 with SMTP id
 f11-20020a170906738b00b009a2086af9b7mr12235071ejl.59.1696348444408; Tue, 03
 Oct 2023 08:54:04 -0700 (PDT)
MIME-Version: 1.0
References: <20230922175741.635002-1-yosryahmed@google.com>
 <20230922175741.635002-3-yosryahmed@google.com> <20231003131309.GD17012@cmpxchg.org>
In-Reply-To: <20231003131309.GD17012@cmpxchg.org>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Tue, 3 Oct 2023 08:53:25 -0700
Message-ID: <CAJD7tkZ7CrQpbqZ5G87YMgir2Sj5oE1XiqnqPVJwW_o8y8pR2A@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] mm: memcg: normalize the value passed into memcg_rstat_updated()
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Shakeel Butt <shakeelb@google.com>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Muchun Song <muchun.song@linux.dev>,
        =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
        linux-mm@kvack.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Oct 3, 2023 at 6:13=E2=80=AFAM Johannes Weiner <hannes@cmpxchg.org>=
 wrote:
>
> On Fri, Sep 22, 2023 at 05:57:40PM +0000, Yosry Ahmed wrote:
> > memcg_rstat_updated() uses the value of the state update to keep track
> > of the magnitude of pending updates, so that we only do a stats flush
> > when it's worth the work. Most values passed into memcg_rstat_updated()
> > are in pages, however, a few of them are actually in bytes or KBs.
> >
> > To put this into perspective, a 512 byte slab allocation today would
> > look the same as allocating 512 pages. This may result in premature
> > flushes, which means unnecessary work and latency.
>
> Yikes.
>
> I'm somewhat less concerned about the performance as I am about the
> variance in flushing cost that could be quite difficult to pinpoint.
> IMO this is a correctness fix and a code cleanup, not a performance
> thing.

Agreed, the code right now has a subtle mistake.

>
> > Normalize all the state values passed into memcg_rstat_updated() to
> > pages. Round up non-zero sub-page to 1 page, because
> > memcg_rstat_updated() ignores 0 page updates.
> >
> > Fixes: 5b3be698a872 ("memcg: better bounds on the memcg stats updates")
> > Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
>
> Acked-by: Johannes Weiner <hannes@cmpxchg.org>

Thanks for taking a look!
