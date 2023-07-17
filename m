Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44A72756DA5
	for <lists+cgroups@lfdr.de>; Mon, 17 Jul 2023 21:52:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229471AbjGQTw2 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 17 Jul 2023 15:52:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229634AbjGQTw1 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 17 Jul 2023 15:52:27 -0400
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3ABF126;
        Mon, 17 Jul 2023 12:52:26 -0700 (PDT)
Received: by mail-io1-xd29.google.com with SMTP id ca18e2360f4ac-78654448524so183423139f.2;
        Mon, 17 Jul 2023 12:52:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689623546; x=1692215546;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xWoO0TUyoZ+Qmv9rHsFJp85hT+0xnOPhDe/kh1QoW+4=;
        b=b/OD9dQBwXE1T8MrYijlWFmG5nFgVYLUSGDixvQrh4A+Vyno/KDVv+Pz7WNzBol1c7
         hgPj6C5a/CdM8V4v9GlJbGJegX4cmUqZhY386PFQo/u2kdOS0H4F+ItE8lvfOabQMBq4
         B+t9XaxuY0MkH70snVL8s0ePHjc8aFM4oFpf04Gbq9YxNiylU21jGRFT0TNyzjtuCIgC
         4PuELLmlzmV0xkS9mzXnFdHXNCEkugpQcM7PUci+dtuq5vf475R0VjnGL8r4cmHGgXTo
         /swLnuNI5MMi1CSwtcMJdKE52LgaAn2tNjyeq/xMKoRE3jD+BOKiRoB2KLYtpMkgvRrm
         2Nwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689623546; x=1692215546;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xWoO0TUyoZ+Qmv9rHsFJp85hT+0xnOPhDe/kh1QoW+4=;
        b=ffEVZK8lXuDEplQMwal+DoztshOHznxH4dIgMJbuhxfAVZ6CaJpWMfgctgjqcmwMnH
         TuBKOJwJqeKyWqOn5VNcq+Br71kuNAxomHqB7DYrjyyvOuIcgtcH+9YGgwAdTf87tARs
         Skh6AHesYnLnt6wNOS3NTOlYhl7BJ+h3Tq3mOP0fKwSlT/Tsc710ay8MNYqSDfwuTC6o
         nVwEAkHMx0ALXBpLdip6NMigNJG+ctVl4rniLtgXgTrIsH1NM/ZWhGh6gjn4QauvbA3+
         6DSC/4FhvvPZooqICLNQukwAEf7XUV7EHJvqdd/bi6H44QFaT5VNFiGBiTnpYgIU18yi
         3BnQ==
X-Gm-Message-State: ABy/qLZrNQkRj3ce/3YsQ+N/yeax0HxwwsShd6fMEBSIMKMH/v4KgJvw
        2sZL4clAgDTHb2xwnElw7MA=
X-Google-Smtp-Source: APBJJlHSUjxifSVrVdCDPxEBiVa/8JHHvBQsZfY+DBkng5FQSGGbHQXRLjsIy6hbVB/K0igUqin82w==
X-Received: by 2002:a5d:9544:0:b0:780:bf50:32ce with SMTP id a4-20020a5d9544000000b00780bf5032cemr615151ios.19.1689623545792;
        Mon, 17 Jul 2023 12:52:25 -0700 (PDT)
Received: from localhost (dhcp-72-235-13-41.hawaiiantel.net. [72.235.13.41])
        by smtp.gmail.com with ESMTPSA id t11-20020a6b090b000000b0077e35ffac2fsm68393ioi.32.2023.07.17.12.52.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Jul 2023 12:52:25 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Mon, 17 Jul 2023 09:52:24 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Hao Jia <jiahao.os@bytedance.com>
Cc:     lizefan.x@bytedance.com, hannes@cmpxchg.org, mkoutny@suse.com,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cgroup/rstat: record the cumulative per-cpu time of
 cgroup and its descendants
Message-ID: <ZLWb-LsBD041hMvr@slm.duckdns.org>
References: <20230717093612.40846-1-jiahao.os@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230717093612.40846-1-jiahao.os@bytedance.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hello,

On Mon, Jul 17, 2023 at 05:36:12PM +0800, Hao Jia wrote:
> Now the member variable bstat of the structure cgroup_rstat_cpu

You said "now" indicating that the behavior has changed recently but I don't
see what changed there. Can you elaborate?

> records the per-cpu time of the cgroup itself, but does not
> include the per-cpu time of its descendants. The per-cpu time

It does. The per-cpu delta is added to its parent and then that will in turn
be used to propagate to its parent.

> including descendants is very useful for calculating the
> per-cpu usage of cgroups.
> 
> Although we can indirectly obtain the total per-cpu time
> of the cgroup and its descendants by accumulating the per-cpu
> bstat of each descendant of the cgroup. But after a child cgroup
> is removed, we will lose its bstat information. This will cause
> the cumulative value to be non-monotonic, thus affecting
> the accuracy of cgroup per-cpu usage.
> 
> So we add the cumul_bstat variable to record the total
> per-cpu time of this cgroup and its descendants, which is
> similar to "cpuacct.usage*" in cgroup v1. And this is
> also helpful for the migration from cgroup v1 to cgroup v2.
> After adding this variable, we can obtain the per-cpu time of
> cgroup and its descendants in user mode through eBPF, etc.

I think you're misunderstanding how the code works. Can you please double
check?

Thanks.

-- 
tejun
