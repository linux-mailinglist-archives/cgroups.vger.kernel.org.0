Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C3EE39B857
	for <lists+cgroups@lfdr.de>; Fri,  4 Jun 2021 13:52:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230271AbhFDLyE (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 4 Jun 2021 07:54:04 -0400
Received: from mail-wr1-f50.google.com ([209.85.221.50]:38517 "EHLO
        mail-wr1-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230266AbhFDLyE (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 4 Jun 2021 07:54:04 -0400
Received: by mail-wr1-f50.google.com with SMTP id c9so335838wrt.5
        for <cgroups@vger.kernel.org>; Fri, 04 Jun 2021 04:52:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=nmP5AGQDJHyblHijhBlqQ7scqZzB+IznwgL38+TeSNM=;
        b=ZAlxWVBtcKxrDjkMXih764aGrC3O08Yb/bplxtTlgEtkni/fyJgyzoe3B8nvwoL2kj
         +4EaZPbiAzOhyGJyPs+QB3gqOY/lA5qhbBXOyrYwKIV16Taqm4Qfi6/spb3pKc255DS4
         rmhTOzbc725b2O8qU5ltrkbJWQRadCm5lQl60=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=nmP5AGQDJHyblHijhBlqQ7scqZzB+IznwgL38+TeSNM=;
        b=Hh2sM3IHVNV1Ohb+oCbadyqfuCGAStM+1Ed2EBce8qq8WhlJ1BMQq3x5F0Gcs8p6v1
         b46/bHecg2tPSzf9a+z+ygZKkvsw/uiy/dIzS9pBh73WKvalRFMst2GKDB6wWovTGvZq
         YYNMP+c7vpol0q/MMMFvOC7ppJbPibKo5XMPw7pF+V/rKUXOqf5inffMmJM4LrCnbnlh
         PjqNH/eaIXVXE7seEFrnuOOQv0Pizv+sh44H5cASFgW4XuFbEf/YKxlUfhxL97VigRN4
         nY0rqjoSNkg5MTB6ij3sriH+vFYqLISSkp0yuZ5SuM5hOax5Cw+NkER9UhntwPrFjDOC
         ykIg==
X-Gm-Message-State: AOAM533uQ7Wi78RYzWj6YG1VDwIXQ7aUiUIM6xxflxhTCU1vx7mRQfPw
        aTzzplExsVuXz+oHE1Rubuqexw==
X-Google-Smtp-Source: ABdhPJyZYMdm9ao/cla2kqJl+X6Uax9vqT0cMOWJ5115PjwBviWGzoJllV3Br2cjPFhJ8L/Dm9mRhA==
X-Received: by 2002:adf:8b9a:: with SMTP id o26mr3481350wra.96.1622807461449;
        Fri, 04 Jun 2021 04:51:01 -0700 (PDT)
Received: from localhost ([2620:10d:c093:400::5:fc89])
        by smtp.gmail.com with ESMTPSA id z10sm5649645wmb.26.2021.06.04.04.51.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Jun 2021 04:51:00 -0700 (PDT)
Date:   Fri, 4 Jun 2021 12:51:00 +0100
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
Message-ID: <YLoTpLnmiIKBzpfh@chrisdown.name>
References: <cover.1622043596.git.yuleixzhang@tencent.com>
 <CALvZod4SoCS6ym8ELTxWd6UwzUp8m_UUdw7oApAhW2WRq0BXqw@mail.gmail.com>
 <CACZOiM3VhYyzCTx4FbW=FF8WB=X46xaV53abqOVL+eHQOs8Reg@mail.gmail.com>
 <YLZIBpJFkKNBCg2X@chrisdown.name>
 <CACZOiM21STLrZgcnEwm8w2t82Qj3Ohy-BGbD5u62gTn=z4X3Lw@mail.gmail.com>
 <CALvZod7w1tzxvYCP54KHEo=k=qUd02UTkr+1+b5rTdn-tJt45w@mail.gmail.com>
 <CACZOiM3g6GhJgXurMPeE3A7zO8eUhoUPyUvyT3p2Kw98WkX8+g@mail.gmail.com>
 <YLi/UeS71mk12VZ3@chrisdown.name>
 <CACZOiM03toiqcbtEd8LT26T2GtPsDaFj89o8rjEfELTw=KPvfg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <CACZOiM03toiqcbtEd8LT26T2GtPsDaFj89o8rjEfELTw=KPvfg@mail.gmail.com>
User-Agent: Mutt/2.0.7 (481f3800) (2021-05-04)
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

yulei zhang writes:
>> Having a speed throttle is a very primitive knob: it's hard to know what the
>> correct values are for a user. That's one of the reasons why we've moved away
>> from that kind of tunable for blkio.
>>
>> Ultimately, if you want work-conserving behaviour, why not use memory.low?
>
>Thanks. But currently low and high are for cgroup v2 setting, do you
>think we'd better
>extend the same mechanism to cgroup v1?

The cgroup v1 interface is frozen and in pure maintenance mode -- we're not 
adding new features there and haven't done so for some time.
