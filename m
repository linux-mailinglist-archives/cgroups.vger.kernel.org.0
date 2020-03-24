Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DD7FC191861
	for <lists+cgroups@lfdr.de>; Tue, 24 Mar 2020 19:03:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727333AbgCXSBn (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 24 Mar 2020 14:01:43 -0400
Received: from mail-qt1-f176.google.com ([209.85.160.176]:35960 "EHLO
        mail-qt1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727223AbgCXSBm (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 24 Mar 2020 14:01:42 -0400
Received: by mail-qt1-f176.google.com with SMTP id m33so15757032qtb.3;
        Tue, 24 Mar 2020 11:01:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=WTcUW0G2da/p6PXHgnEzI2FtMutVR8dAOTnWSKNo/+8=;
        b=fVKbJ0LHDno6UVMja5OyHYNwO6yCqhK1y3EJW23eRpqc3oLwkZVCCHkDqeP7sKA+QB
         ODf5aQrksDN+cOXyxvOmleitLuwhhjOcSmmOPRq+sIxi7IPWAxkAtnfM9pr1O7dG8fWc
         fvVPXU9zFB5XG8M+QtnplZPCqJiQrEy4ILlta4NAGap3zegdIxwUwOOYc3/NRmsIUsMw
         SH0lejDsepTjd9xxpMTjPsXy/MOuCQQx8SP/fiDqNPD5Vt2DrkKQkqWmR3U/1F0eYeoU
         Wl+Y11QpqpR7GbWrfdwyu1zHn1YLiX5j697r1x9qCTyKa6s1KGptQW9O2TCjdN7KsvGf
         G9sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=WTcUW0G2da/p6PXHgnEzI2FtMutVR8dAOTnWSKNo/+8=;
        b=QbEHVpVdIRhlPenj196kbVyd9ZlpZJbZeLrWXL9xEFbioIaJxCcww+T9fKDDFvw9Pv
         /1Ekgd/LT335fryyT8NRE/LJys4NRGgKi6kN1J3Jbu9RpPO9vhaYPDb60dlAjHnISC07
         kM6IQOMHCgk7EQLVWythkv9nbWvMDPr+iqMgMapM6oWKfWwZJr/EPjk0NnwW7A+vfb9c
         hpinzHPoDmAANa4Yt+AblyYrVbAt08z8wQyRBLYWL2avz1dBquQe1DlVeWLnEoqaoXeg
         m7xqckEPEEuMvrPIsDTUmNeWFGm8vEoZnUDiygEG7DdT9YDv8PObjJCyYX9H78OIKMVY
         Zy9Q==
X-Gm-Message-State: ANhLgQ3gDIlEPPKE7bQsrw2tGVRNwX7JqXofZe1E2Cc2NATnSN5Zl3ik
        UgLPqBgja0zr4NfM04qAT9U=
X-Google-Smtp-Source: ADFU+vvNWDEUA7vOK1G2JGNgFpG35jd7R3WvWS0yKKB1JnYYZXp9Nf6+nvRKb+yPmtkuiCnbcDsHrA==
X-Received: by 2002:aed:2a05:: with SMTP id c5mr19935107qtd.248.1585072901426;
        Tue, 24 Mar 2020 11:01:41 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::19c2])
        by smtp.gmail.com with ESMTPSA id n142sm13149843qkn.11.2020.03.24.11.01.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Mar 2020 11:01:40 -0700 (PDT)
Date:   Tue, 24 Mar 2020 14:01:39 -0400
From:   Tejun Heo <tj@kernel.org>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     Li Zefan <lizefan@huawei.com>, cgroups <cgroups@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>
Subject: Re: [regression] cpuset: offlined CPUs removed from affinity masks
Message-ID: <20200324180139.GB162390@mtj.duckdns.org>
References: <1251528473.590671.1579196495905.JavaMail.zimbra@efficios.com>
 <20200219154740.GD698990@mtj.thefacebook.com>
 <59426509.702.1582127435733.JavaMail.zimbra@efficios.com>
 <20200219155202.GE698990@mtj.thefacebook.com>
 <1358308409.804.1582128519523.JavaMail.zimbra@efficios.com>
 <20200219161222.GF698990@mtj.thefacebook.com>
 <316507033.21078.1583597207356.JavaMail.zimbra@efficios.com>
 <20200312182618.GE79873@mtj.duckdns.org>
 <1289608777.27165.1584042470528.JavaMail.zimbra@efficios.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1289608777.27165.1584042470528.JavaMail.zimbra@efficios.com>
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Sorry about long delay.

On Thu, Mar 12, 2020 at 03:47:50PM -0400, Mathieu Desnoyers wrote:
> The basic idea is to allow applications to pin to every possible cpu, but
> not allow them to use this to consume a lot of cpu time on CPUs they
> are not allowed to run.
> 
> Thoughts ?

One thing that we learned is that priority alone isn't enough in isolating cpu
consumptions no matter how low the priority may be if the workload is latency
sensitive. The actual computation capacity of cpus gets saturated way before cpu
time is saturated and latency impact from lowered mips becomes noticeable. So,
depending on workloads, allowing threads to run at the lowest priority on
disallowed cpus might not lead to behaviors that users expect but I have no idea
what kind of usage models you have on mind for the new system call.

Thanks.

-- 
tejun
