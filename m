Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3313859C3A5
	for <lists+cgroups@lfdr.de>; Mon, 22 Aug 2022 18:05:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235047AbiHVQFU (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 22 Aug 2022 12:05:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234947AbiHVQFM (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 22 Aug 2022 12:05:12 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61AFA255AF
        for <cgroups@vger.kernel.org>; Mon, 22 Aug 2022 09:05:11 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id v4so9761250pgi.10
        for <cgroups@vger.kernel.org>; Mon, 22 Aug 2022 09:05:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=Gsdq66BkjynIpRPrwWnOavgdKVDsGQ5+owwtyl9S4wc=;
        b=FCtgY9iinm8oIY5V3F0fuHisMULPTP8CQ+xh/Bo5Gk3eVocKSH5pJdqM+NrFCk5yNp
         C/YGEDtKfv2IeT6AmCu73ng/KgcB1e3J6zvGZBDJaQRXHcj3tN23Tv/MhEOscujEMLJ5
         xyYk5bpEg2crzlxiekFp9X9OD/yfiaG6k0mDe8aulUmg8Umb7MrkjHZX4pGlK3JTLFNe
         Ywl56Z7zDPixLCxQT7eP7burucLhwhQBi8Bmc51HtR0S3LB5qkV698CWc9NctsG4DkCE
         5U6M+vkFI6nGdhVyAgLZmrPCSAgv732qwe2Dng3VOnpr0ocEVXV6qBHvaBbf6pfIfatM
         h98g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=Gsdq66BkjynIpRPrwWnOavgdKVDsGQ5+owwtyl9S4wc=;
        b=7sPUvzODRkCqAunQ9j1MG3suVHZGLIRJJ7eDjrMDE42k6jrjKgDTI3l6EUTBqJ0fiW
         c1L0zu3CYE/7Ktw3UShiioEcR3v5CsVi5luaN8lnsWC8aUM1f3voeEtRv8VP3Px/7kD9
         qxwixatqvFCUtTNuhBNLRtmbJ/2zKChKVeqQOUymduK8ILNp/hScwKwy+RZqS1yN+087
         qMHAfA3r1E7BLwJh5923kLEOYsjW8aALvInYJ8QMKsAnfTMnXAlP5KUqWhlMYS/lLQ7n
         tMEj4dCY/54LhW0BAit6/Nxpm86tp1O/iBoJkL0u40oDbV+IExib35bFBOLVfqtLb8ph
         1N3w==
X-Gm-Message-State: ACgBeo1fCfHXHdKMOFjSepdEp2AiiREYJTGYdNzvlyKdDcTDJI6ga2EU
        6b35shKZ7/twycIjMSLLmgSVxQX7p4TBAXuanenvgA==
X-Google-Smtp-Source: AA6agR6sdwDfhdjqCX6dqJyxJ5ybluZ96v9XhwuPllXX1mMtxZCnsOVM4A+fRNO2CxOVQx85qxZzBP7d5u49kiL0mQY=
X-Received: by 2002:a63:5f8e:0:b0:429:c286:4ef7 with SMTP id
 t136-20020a635f8e000000b00429c2864ef7mr17156340pgb.166.1661184310649; Mon, 22
 Aug 2022 09:05:10 -0700 (PDT)
MIME-Version: 1.0
References: <20220822001737.4120417-1-shakeelb@google.com> <20220822001737.4120417-3-shakeelb@google.com>
 <YwNZD4YlRkvQCWFi@dhcp22.suse.cz> <CALvZod5pw_7hnH44hdC3rDGQxQB2XATrViNNGosG3FnUoWo-4A@mail.gmail.com>
 <YwOde3qFvne7Umld@dhcp22.suse.cz>
In-Reply-To: <YwOde3qFvne7Umld@dhcp22.suse.cz>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Mon, 22 Aug 2022 09:04:59 -0700
Message-ID: <CALvZod4whYX+0ZuCGgyKuG-Q_9d0g7N_x+=WXOeB_1TM=3Q7vg@mail.gmail.com>
Subject: Re: [PATCH 2/3] mm: page_counter: rearrange struct page_counter fields
To:     Michal Hocko <mhocko@suse.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Muchun Song <songmuchun@bytedance.com>,
        =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>,
        Eric Dumazet <edumazet@google.com>,
        Soheil Hassas Yeganeh <soheil@google.com>,
        Feng Tang <feng.tang@intel.com>,
        Oliver Sang <oliver.sang@intel.com>,
        Andrew Morton <akpm@linux-foundation.org>, lkp@lists.01.org,
        Cgroups <cgroups@vger.kernel.org>, Linux MM <linux-mm@kvack.org>,
        netdev <netdev@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon, Aug 22, 2022 at 8:15 AM Michal Hocko <mhocko@suse.com> wrote:
>
> On Mon 22-08-22 08:06:14, Shakeel Butt wrote:
> [...]
> > > >  struct page_counter {
> > > > +     /*
> > > > +      * Make sure 'usage' does not share cacheline with any other field. The
> > > > +      * memcg->memory.usage is a hot member of struct mem_cgroup.
> > > > +      */
> > > > +     PC_PADDING(_pad1_);
> > >
> > > Why don't you simply require alignment for the structure?
> >
> > I don't just want the alignment of the structure. I want different
> > fields of this structure to not share the cache line. More
> > specifically the 'high' and 'usage' fields. With this change the usage
> > will be its own cache line, the read-most fields will be on separate
> > cache line and the fields which sometimes get updated on charge path
> > based on some condition will be a different cache line from the
> > previous two.
>
> I do not follow. If you make an explicit requirement for the structure
> alignement then the first field in the structure will be guarantied to
> have that alignement and you achieve the rest to be in the other cache
> line by adding padding behind that.

Oh, you were talking explicitly about _pad1_, yes, we can remove it
and make the struct cache align. I will do it in the next version.
