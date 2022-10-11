Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCB5C5FA93A
	for <lists+cgroups@lfdr.de>; Tue, 11 Oct 2022 02:20:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229956AbiJKAUB (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 10 Oct 2022 20:20:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229899AbiJKAT7 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 10 Oct 2022 20:19:59 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E090237C1
        for <cgroups@vger.kernel.org>; Mon, 10 Oct 2022 17:19:59 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id bh13so11517980pgb.4
        for <cgroups@vger.kernel.org>; Mon, 10 Oct 2022 17:19:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nGoDydYwFqmdmKnzszjtdksfmEzjuo68M+fcbC8JTZY=;
        b=QPrMaTYMX+LHlEAtR3315wlbrXxpmZ1K7YcQlmqqnIpk31rj6HUOZ1Ffg9aT5fLggb
         1O90ZeenAkme/4IkAJdUtxWVMSkl+HmXS5wHZJBQa8GjCXGegDBILU63HFPUhc8hK01G
         BW0LjruEDo5XihSvmvg4K4Po75yhE8+8/cmXTAOKsXPTAU1LLm1unGLLLHafwVTiE9BX
         dx4+X/eqosgRmoe0CnEIPGp+WMFt+IrtKiIOi6ZreiN1Jcplfw7K9z0+9DOelRiOKIGY
         VzQ4pAKqsew/a2wz5RvyLOdw6bqVkw7LDGUKqQvas9j9At4bnxn7g1iEIF/sCGWZsyhp
         5goQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nGoDydYwFqmdmKnzszjtdksfmEzjuo68M+fcbC8JTZY=;
        b=0eNj6aEwsS3SvwjGVfFqqWtyC96qb6bfK0fGw5M0uTLIjfEYH/a8F6wnqxFhtmfMby
         dfgsQ0OEkEM9gbSpiu26F7YIPx1kJOvzFduVX7TPcUOn+H6ttQIE97XGbgGE5SzFxBQk
         Lj5rf1uAje9JB1mpjoDFObVHctBHUty1HX3Rsyv+NRJtPinnnl9YcK5Vqw3zRT1yO1D3
         uo9HcGh86r0EqKW+6iSQ3sjngOj4lmJ/TmYMVXvCNxjsfYZtNNQSJ4Ugo5trRy7sQyd0
         1xEYtuQ0NkzX9ri48wBhQT2mrWPknbaCJIhmtkJfXtAUcARbfT/1LgBKHdqSF/P48q18
         UtTg==
X-Gm-Message-State: ACrzQf2EfSlQZMNHZH1G2koRiL9SMztVa6x+hU6rcaxmlLnriHfhyTC0
        t6AQvvoUkpbFdxo0QuEf9QA=
X-Google-Smtp-Source: AMsMyM6iUIeUKkPK0NW7DtFwndoCMTUi35JPal7UTV5H7IwffjYrHvCX45d+6Oyl75ZC43wn5FaAvA==
X-Received: by 2002:a05:6a00:150e:b0:563:b133:2932 with SMTP id q14-20020a056a00150e00b00563b1332932mr529534pfu.37.1665447598432;
        Mon, 10 Oct 2022 17:19:58 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id n30-20020a17090a5aa100b0020a11217682sm3413822pji.27.2022.10.10.17.19.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Oct 2022 17:19:58 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Mon, 10 Oct 2022 14:19:56 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Yosry Ahmed <yosryahmed@google.com>
Cc:     Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Shakeel Butt <shakeelb@google.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux-MM <linux-mm@kvack.org>, Cgroups <cgroups@vger.kernel.org>,
        Greg Thelen <gthelen@google.com>
Subject: Re: [RFC] memcg rstat flushing optimization
Message-ID: <Y0S2rPSfpCf2AMod@slm.duckdns.org>
References: <CAJD7tkZQ+L5N7FmuBAXcg_2Lgyky7m=fkkBaUChr7ufVMHss=A@mail.gmail.com>
 <Yz2xDq0jo1WZNblz@slm.duckdns.org>
 <CAJD7tkawcrpmacguvyWVK952KtD-tP+wc2peHEjyMHesdM1o0Q@mail.gmail.com>
 <Yz3CH7caP7H/C3gL@slm.duckdns.org>
 <CAJD7tkY8gNNaPneAVFDYcWN9irUvE4ZFW=Hv=5898cWFG1p7rg@mail.gmail.com>
 <Yz3LYoxhvGW/b9yz@slm.duckdns.org>
 <CAJD7tkZOw9hrc0jKYqYW1ysGZNjSVDgjhCyownBRmpS+UUCP3A@mail.gmail.com>
 <CAJD7tkZZuDwGHDjAsOde0VjDm9YcKWnWUGHg43q79hcffZH5Xw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJD7tkZZuDwGHDjAsOde0VjDm9YcKWnWUGHg43q79hcffZH5Xw@mail.gmail.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hello,

On Mon, Oct 10, 2022 at 05:15:33PM -0700, Yosry Ahmed wrote:
> Any thoughts here, Tejun or anyone?

I'm having a bit of hard time imagining how things would look like without
code and I think we'd need inputs from mm folks re. the tradeoff between
information timeliness and overhead.

Thanks.

-- 
tejun
