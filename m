Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 915FD5AF47E
	for <lists+cgroups@lfdr.de>; Tue,  6 Sep 2022 21:37:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229693AbiIFThU (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 6 Sep 2022 15:37:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbiIFThT (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 6 Sep 2022 15:37:19 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7C69910A9
        for <cgroups@vger.kernel.org>; Tue,  6 Sep 2022 12:37:18 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id x1so7929187plv.5
        for <cgroups@vger.kernel.org>; Tue, 06 Sep 2022 12:37:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :from:to:cc:subject:date;
        bh=XJcSopcn6kgTqhrI+8/s9+7y1PjjuR0jL1WX7rSqHbk=;
        b=fTqAmgzRhEwcGwkE0UoFGilloqSV9UoPG09wyE7gsvAfrtF+KGwZme1wLJf7vcAFwq
         pdeZnMkgDyIN2YVg+xwRZ5j0O2ii9gLe/p/fyuPKxB8tmy9YI+phLxVrIQLr73PkM4R7
         LjjciXRzs3h9cLvAymNkHOXHBNIkyPvbo+jPIgOhvrIrsBsICuJgL9d/WLkCm7Li+eZq
         JxmNx/rGn79jjmWZwhu5wwlOcLLZh3LMB45d6JkDvCdgcuD8+Uncrok3HJDImZs+mTCB
         UINHhbrq203isIaXOcNHpLmXi74vg4UPOAdxAz+YJu3cLOGxswTfqOrWZHcE18DxrzEu
         BFxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :x-gm-message-state:from:to:cc:subject:date;
        bh=XJcSopcn6kgTqhrI+8/s9+7y1PjjuR0jL1WX7rSqHbk=;
        b=jb/8ZZ7qMITT8jIFwec4hcbspzXR31TBEvANoaCcFXeoHxNsRrhIs3ah2/u3OZSbaz
         hvcLKDkG1RsSQ/cAq6F5FawoQcTCly5fgvfdJp/Kzq0Ypot8Hyil1CtzT95IHYxGRBYN
         GF4To9SC0RyzUUA4qxjIkWN5OoIZpIB/ZST4dQm8XVJOO0l5v54l/zDNiLqT+rdnxOSl
         hUPLQXcFKOPl08WRDkbd2ygB4ZFMF9IgUvT39Y2/9znIGqatfHj7Q0OY43BpoEF21F8c
         K42CRtg9qO05ZIW3ZxqnuCynIUoN2JhQHYMBU1UyTsnLibaXUTBCd7QX2UQbO01a2Jt+
         9+Zg==
X-Gm-Message-State: ACgBeo0kdW7n2spu/etN8k0X1KhGE+b6PpVM/U9FJ/IhZZItGlOt6+N/
        1ELMpUpOEOxGDSa+b5aGz0o=
X-Google-Smtp-Source: AA6agR52cxbyA6nroPYH+CRlFIp1xo8iYHhGjwPk0o63PYhUMDSM5g/DSpuiqvDdBRRezxTYjw1Uwg==
X-Received: by 2002:a17:903:204b:b0:176:a6c5:4277 with SMTP id q11-20020a170903204b00b00176a6c54277mr77326pla.24.1662493038137;
        Tue, 06 Sep 2022 12:37:18 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id be7-20020a656e47000000b0041a716cec9esm8771893pgb.62.2022.09.06.12.37.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Sep 2022 12:37:17 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Tue, 6 Sep 2022 09:37:16 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
Cc:     Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>, cgroups@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH 1/2 cgroup/for-6.1] cgroup: Improve cftype add/rm error
 handling
Message-ID: <YxehbNMr998iITHi@slm.duckdns.org>
References: <YxUUISLVLEIRBwEY@slm.duckdns.org>
 <20220905131435.GA1765@blackbody.suse.cz>
 <YxeCdHfk2nOUISDw@slm.duckdns.org>
 <20220906191112.GF30763@blackbody.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220906191112.GF30763@blackbody.suse.cz>
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

On Tue, Sep 06, 2022 at 09:11:12PM +0200, Michal Koutný wrote:
> Before the return here, the function should revert the base files first (or
> silence the return value to 0 if such a partial population is acceptable).
> 
> (Actually, it looks like the revert in the subsys branch is unnecessary as
> callers of css_populate_dir() would issue css_clear_dir() upon failure
> eventually.)

Yeah, so, the contract there is a bit unusual in that on failure the helpers
don't need to cleanup after themselves as they'll get cleaned up together by
the caller when it nukes the cgroup which was being created. While a bit
unusual, it's simpler / safer this way, so...

Thanks.

-- 
tejun
