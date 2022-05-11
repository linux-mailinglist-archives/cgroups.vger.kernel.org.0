Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5502522A44
	for <lists+cgroups@lfdr.de>; Wed, 11 May 2022 05:17:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241539AbiEKDRt (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 10 May 2022 23:17:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241468AbiEKDRr (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 10 May 2022 23:17:47 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7E013B558;
        Tue, 10 May 2022 20:17:46 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id iq2-20020a17090afb4200b001d93cf33ae9so3666381pjb.5;
        Tue, 10 May 2022 20:17:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:from:to:cc:subject:references:mime-version
         :content-disposition:in-reply-to;
        bh=aeafOzN+KhT6xUt6Ci9vzPISfyWvX+i2zyBA9FualR8=;
        b=mjeGKZrdMWExTOJ6nPIF/ql6gb2ybbylcxERjkn8bZkniAbu+OkCrh5PZomXGZrpa4
         CyAZIcyYNW2HF13bB/wwbu5e3Bw36U7BWCWdePNlS1qBWVrwwatm6VabqeT3f4wJAX74
         f5/BgNdy4+Sdo3Im6khhbbqCdAb4FfNDDIl6lM7EezVKU7aCEWIO2yhAR2P1L1HoLzTU
         ZjPAz4p2JhBF9H6znOW4wi8xBa1OdS7MAMM+DbDy0ayTCYCOKfm7nd6ej2fKBn61MoPe
         XeCCJY2JjdzZJYmI8gwKcfzJxvgd+8RnQSG+0PrjgGXJ9ybnx7vpK5WA4gD7IfKkgc0O
         wSkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:from:to:cc:subject:references
         :mime-version:content-disposition:in-reply-to;
        bh=aeafOzN+KhT6xUt6Ci9vzPISfyWvX+i2zyBA9FualR8=;
        b=SSh9+JqCOcYszPGmQtbAe/YD8uQ/2hgkWpbzhXcx70Mktg4qYK48OkMACztjoO7tLZ
         G9DI0U5hzzd1TAkPk6/gTkNl/RbYGLCFbZA38LnxGLjS/oWe0bDxb/KVvH7nZ1LEf9jH
         0JkFZIjtA9D4E0XaGaINQlP8Eh2Er1/yiae9WZJap+aPM0EFi6NiEEuCeUyBwftpvTZO
         SqzjEuGM4EDkpW/rkWfDueh3RwGn1t+qv/whH3Y2I1cEZeUKLSPNsGsVcxTSeNsNFnvI
         uaIvs8b84ipKNMlXFKwo5PMadt6B5Z4XMPXAapKoSll9LqXheSn3qlzszF33jdDesWr7
         MwIQ==
X-Gm-Message-State: AOAM531Zm6lISlgmw8IKdX+Wv/s5aMCLkQNzpJ6xb+VcmlHYQsfXRnNE
        WwnlJkaH/VRIo8jv7xo38ho=
X-Google-Smtp-Source: ABdhPJzuDCrXWj27Bp+TxP4Ag9W3lfCdFyaSyYAQH8xHrdDBO+s6hWJQXjFez5nZcUr36BNPHtd/6w==
X-Received: by 2002:a17:90a:f310:b0:1db:effb:a614 with SMTP id ca16-20020a17090af31000b001dbeffba614mr3064928pjb.233.1652239066326;
        Tue, 10 May 2022 20:17:46 -0700 (PDT)
Received: from localhost ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id 11-20020a63184b000000b003c14af5062fsm446612pgy.71.2022.05.10.20.17.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 May 2022 20:17:45 -0700 (PDT)
Message-ID: <627b2ad9.1c69fb81.f2bc7.19d6@mx.google.com>
X-Google-Original-Message-ID: <20220511031744.GA1494607@cgel.zte@gmail.com>
Date:   Wed, 11 May 2022 03:17:44 +0000
From:   CGEL <cgel.zte@gmail.com>
To:     Shakeel Butt <shakeelb@google.com>
Cc:     Yang Shi <shy828301@gmail.com>, Michal Hocko <mhocko@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Matthew Wilcox <willy@infradead.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Miaohe Lin <linmiaohe@huawei.com>,
        William Kucharski <william.kucharski@oracle.com>,
        Peter Xu <peterx@redhat.com>, Hugh Dickins <hughd@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Muchun Song <songmuchun@bytedance.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        Cgroups <cgroups@vger.kernel.org>,
        Yang Yang <yang.yang29@zte.com.cn>
Subject: Re: [PATCH] mm/memcg: support control THP behaviour in cgroup
References: <20220505033814.103256-1-xu.xin16@zte.com.cn>
 <YnUlntNFR4zeD+qa@dhcp22.suse.cz>
 <6275d3e7.1c69fb81.1d62.4504@mx.google.com>
 <YnjmPAToTR0C5o8x@dhcp22.suse.cz>
 <6278fa75.1c69fb81.9c598.f794@mx.google.com>
 <Ynj/l+pyFJxKfcbQ@dhcp22.suse.cz>
 <6279c354.1c69fb81.7f6c1.15e0@mx.google.com>
 <CAHbLzkqztB+NXVcxtd7bVo7onH6AcMJ3JWCAHHqH3OAdbZsMOQ@mail.gmail.com>
 <627b1d39.1c69fb81.fe952.6426@mx.google.com>
 <CALvZod5aqZjUE8BBQZxwHDBuSWOSEAOqW4_xE22Am0sGZZs4sw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALvZod5aqZjUE8BBQZxwHDBuSWOSEAOqW4_xE22Am0sGZZs4sw@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, May 10, 2022 at 07:47:29PM -0700, Shakeel Butt wrote:
> On Tue, May 10, 2022 at 7:19 PM CGEL <cgel.zte@gmail.com> wrote:
> >
> [...]
> > > > >
> > > > > All controls in cgroup v2 should be hierarchical. This is really
> > > > > required for a proper delegation semantic.
> > > > >
> > > >
> > > > Could we align to the semantic of /sys/fs/cgroup/memory.swappiness?
> > > > Some distributions like Ubuntu is still using cgroup v1.
> > >
> > > Other than enable flag, how would you handle the defrag flag
> > > hierarchically? It is much more complicated.
> >
> > Refer to memory.swappiness for cgroup, this new interface better be independent.
> 
> Let me give my 0.02. I buy the use-case of Admin restricting THPs to
> low priority jobs but I don't think memory controller is the right
> place to enforce that policy. Michal gave one way (prctl()) to enforce
> that policy. Have you explored the BPF way to enforce this policy?

Thanks!
prctl()(at least for the latest version) only support disable THP, it's semantic is
not very perfection. Maybe we could expand the prctl() for THP?
BPF maybe a way to realize more fine-grained THP control. But I think semantic comes
first.

So what about realize three layers of THP controller? All kinds of users maybe satisfy:
    Layer 1: all system, realized. see /sys/kernel/mm/transparent_hugepage/enabled.
    Layer 2: container/cgroup, unrealized. useful for user who treat container as
lightweight virtual machine, let this overide layer 1.
    Layer 3: process, partial realized. see prctl(), let this overide layer 1 & 2.
