Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7CE01399FF6
	for <lists+cgroups@lfdr.de>; Thu,  3 Jun 2021 13:39:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229854AbhFCLko (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 3 Jun 2021 07:40:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229697AbhFCLko (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 3 Jun 2021 07:40:44 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C59F6C06174A
        for <cgroups@vger.kernel.org>; Thu,  3 Jun 2021 04:38:59 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id z8so5479176wrp.12
        for <cgroups@vger.kernel.org>; Thu, 03 Jun 2021 04:38:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=wiKfBxTb65s9ryPk0mFCpTofRIT4fNKHgWxxNUTFSrY=;
        b=LEUQzE+TXNrsF7VkTKq1fOZ1V0WA+d+HQMLVNnkA/g+4Qw712FXlgXSf8/gadK8Bro
         Kz2E5md4HlTtFR6XSPmsArHCMFvNKKbUz8s6bvVZ8h3VmtAvpACaB0RAtlLg2BQA0irt
         RAl3xa49jeclb3y6buUFOf1iCnIe8lU5lINRo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=wiKfBxTb65s9ryPk0mFCpTofRIT4fNKHgWxxNUTFSrY=;
        b=BCbPeHuszmigo/fUWi2vFrM5cmuXtchmVBsKtJbADq0oPrMCTS+SqBICOLWzc0sxFH
         kHGBNjmtsvBhpEZUpkHTOH3j/CtzfjAAA1OOumcsWFQ3n/smLezNZWzQ+A07EO/jQwZW
         4Qp19kDIwS0Yj1SJZUCLL7RKmpRxyaHsDaZdPn3ywQjFaK8Pl7NgIRq7e5mNHw4zRXVq
         /I2kj0NGma8Pu942u3cwyksRFwyL4A54cvOPPzistIuGdbYi+YswJvzTgIXqpMMDDvsu
         yDaHMlraBq7jNPw6UOxI522akLP0rWwmFXr8H6mIzqFPM9kl4VwRRbuDztFe6xqMc67+
         2xWQ==
X-Gm-Message-State: AOAM530kLmr174JZ4xvOF6fb3uB7Kp+Bb2Z80fFu9YADTyj9v46LG/Fs
        RJnzeKhEv2b6vixzwEwcrjvruA==
X-Google-Smtp-Source: ABdhPJyiojPkL7BvnHVWyvRKsGmV8JltIBBNsXo803sUgldDWytbvs4czs072QurGSSHveY7DFRu1g==
X-Received: by 2002:a5d:4c48:: with SMTP id n8mr8853436wrt.327.1622720338313;
        Thu, 03 Jun 2021 04:38:58 -0700 (PDT)
Received: from localhost ([2620:10d:c093:400::5:6726])
        by smtp.gmail.com with ESMTPSA id t14sm2962551wra.60.2021.06.03.04.38.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Jun 2021 04:38:57 -0700 (PDT)
Date:   Thu, 3 Jun 2021 12:38:57 +0100
From:   Chris Down <chris@chrisdown.name>
To:     yulei zhang <yulei.kernel@gmail.com>
Cc:     Shakeel Butt <shakeelb@google.com>, Tejun Heo <tj@kernel.org>,
        Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Christian Brauner <christian@brauner.io>,
        Cgroups <cgroups@vger.kernel.org>, benbjiang@tencent.com,
        Wanpeng Li <kernellwp@gmail.com>,
        Yulei Zhang <yuleixzhang@tencent.com>,
        Linux MM <linux-mm@kvack.org>,
        Michal Hocko <mhocko@kernel.org>, Roman Gushchin <guro@fb.com>
Subject: Re: [RFC 0/7] Introduce memory allocation speed throttle in memcg
Message-ID: <YLi/UeS71mk12VZ3@chrisdown.name>
References: <cover.1622043596.git.yuleixzhang@tencent.com>
 <CALvZod4SoCS6ym8ELTxWd6UwzUp8m_UUdw7oApAhW2WRq0BXqw@mail.gmail.com>
 <CACZOiM3VhYyzCTx4FbW=FF8WB=X46xaV53abqOVL+eHQOs8Reg@mail.gmail.com>
 <YLZIBpJFkKNBCg2X@chrisdown.name>
 <CACZOiM21STLrZgcnEwm8w2t82Qj3Ohy-BGbD5u62gTn=z4X3Lw@mail.gmail.com>
 <CALvZod7w1tzxvYCP54KHEo=k=qUd02UTkr+1+b5rTdn-tJt45w@mail.gmail.com>
 <CACZOiM3g6GhJgXurMPeE3A7zO8eUhoUPyUvyT3p2Kw98WkX8+g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <CACZOiM3g6GhJgXurMPeE3A7zO8eUhoUPyUvyT3p2Kw98WkX8+g@mail.gmail.com>
User-Agent: Mutt/2.0.7 (481f3800) (2021-05-04)
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

yulei zhang writes:
>Thanks. IMHO, there are differences between these two throttlings.
>memory.high is a per-memcg throttle which targets to limit the memory
>usage of the tasks in the cgroup. For the memory allocation speed throttle(MST),
>the purpose is to avoid the memory burst in cgroup which would trigger
>the global reclaim and affects the timing sensitive workloads in other cgroup.
>For example, we have two pods with memory overcommit enabled, one includes
>online tasks and the other has offline tasks, if we restrict the memory usage of
>the offline pod with memory.high, it will lose the benefit of memory overcommit
>when the other workloads are idle. On the other hand, if we don't
>limit the memory
>usage, it will easily break the system watermark when there suddenly has massive
>memory operations. If enable MST in this case, we will be able to
>avoid the direct
>reclaim and leverage the overcommit.

Having a speed throttle is a very primitive knob: it's hard to know what the 
correct values are for a user. That's one of the reasons why we've moved away 
from that kind of tunable for blkio.

Ultimately, if you want work-conserving behaviour, why not use memory.low?
