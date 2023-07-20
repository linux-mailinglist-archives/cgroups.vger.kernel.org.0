Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6908B75B860
	for <lists+cgroups@lfdr.de>; Thu, 20 Jul 2023 21:57:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231124AbjGTT5N (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 20 Jul 2023 15:57:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229905AbjGTT5N (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 20 Jul 2023 15:57:13 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CDD226AC;
        Thu, 20 Jul 2023 12:57:12 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id 41be03b00d2f7-517bdc9e81dso528668a12.1;
        Thu, 20 Jul 2023 12:57:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689883031; x=1690487831;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=488yUOu99r9XLGMS28MSYzrMwwZ0NrAxoU1mgPEtyC0=;
        b=JMOtgIe5DMCQIM5oGBqiM/ylvwu1hwkVQ2QtHWVBkEpUkMxSBsHgJiIR+2G1Cmd92f
         hAUBEFj/gA1H/BM8ljgqxthlJlVxMD476DlEUWU/1N6EBCogXk6q2lfnqU5N7Y10dcs3
         AlbzAMThKFik0AKakGGOEzM0/6Q1qkYZTz0YA/AooEzuEbU/CD+SD8lVnNX3xr8RxCSU
         Z0kfnx/V4AVR80XTFTSA1OHu1ZT0svkQ43EtUm5dBUMiCtXTeSxMUQfZM5+8wHRc1pfI
         MThEn2/skjYIxiEp09PvzELiObCA7r0EcUFVqOAkb2xbdwig8ciQeTkHCv3PbXXnZNIz
         WHSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689883031; x=1690487831;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=488yUOu99r9XLGMS28MSYzrMwwZ0NrAxoU1mgPEtyC0=;
        b=Gi5PMVcWbHFpozpCsZZmJBo8xijyxQ8nPeij8iX/18KuIPnMBohTMCn6nMS1beUMRL
         AKwjUQIJ+zHG/toT0NWU3+EdY88yHDbliQK5bEVyc+kWwJZk3iNEQ01pyyZIfRBoHYhq
         jO7yZDvs+3MD/djYLu8cVz78YJpXhgL6haQGQxWea8YnJlqyWBYel1dAzjQoQOiC/sUY
         lHdVkqeyQj5ygKd3FgnlPQXR0RNbuCikvnDrvATUa1Ze6azP0C1x9b2tFiwwiqyji10t
         AU5rjfxhtVTawnL3Fsy7B+giuc2rk/xnoSfQOC2uFFCjO6LU9YKAG0ZecO5uHjM1Hmy0
         D1Cw==
X-Gm-Message-State: ABy/qLYsbDoKglVOHwBTCzHxIrBrhpsoGeVyhVYOmsdMVEifFVhWxWq9
        4jXiqAGOurxi3aOIu+O0xjk=
X-Google-Smtp-Source: APBJJlFzO2HyO5mcuIF2ZUo2qUByHsJoAMj9LVDg7u7CaD7sJ5DiLnd7W3E9o4C+kuPn8fD4OmuYrg==
X-Received: by 2002:a17:90b:1106:b0:256:2fd4:e238 with SMTP id gi6-20020a17090b110600b002562fd4e238mr372828pjb.38.1689883031185;
        Thu, 20 Jul 2023 12:57:11 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::5:fbd8])
        by smtp.gmail.com with ESMTPSA id iq1-20020a17090afb4100b0025bf9e02e1bsm1320175pjb.51.2023.07.20.12.57.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jul 2023 12:57:10 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Thu, 20 Jul 2023 09:57:09 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Johannes Weiner <hannes@cmpxchg.org>
Cc:     Yosry Ahmed <yosryahmed@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <muchun.song@linux.dev>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Zefan Li <lizefan.x@bytedance.com>,
        Yu Zhao <yuzhao@google.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Iurii Zaikin <yzaikin@google.com>,
        "T.J. Mercier" <tjmercier@google.com>,
        Greg Thelen <gthelen@google.com>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, cgroups@vger.kernel.org
Subject: Re: [RFC PATCH 0/8] memory recharging for offline memcgs
Message-ID: <ZLmRlTej8Tm82kXG@slm.duckdns.org>
References: <20230720070825.992023-1-yosryahmed@google.com>
 <20230720153515.GA1003248@cmpxchg.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230720153515.GA1003248@cmpxchg.org>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, Jul 20, 2023 at 11:35:15AM -0400, Johannes Weiner wrote:
> It could also be argued that if you don't want to lose control over a
> set of resources, then maybe don't delete their control domain while
> they are still alive and in use. For example, when restarting a
> workload, and the new instance is expected to have largely the same
> workingset, consider reusing the cgroup instead of making a new one.

Or just create a nesting layer so that there's a cgroup which represents the
persistent resources and a nested cgroup instance inside representing the
current instance.

Thanks.

-- 
tejun
