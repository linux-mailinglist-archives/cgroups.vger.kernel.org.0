Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 74D70194FAE
	for <lists+cgroups@lfdr.de>; Fri, 27 Mar 2020 04:32:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727612AbgC0Dc1 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 26 Mar 2020 23:32:27 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:33070 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727607AbgC0Dc1 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 26 Mar 2020 23:32:27 -0400
Received: by mail-qt1-f193.google.com with SMTP id c14so7567577qtp.0
        for <cgroups@vger.kernel.org>; Thu, 26 Mar 2020 20:32:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=r71azbnhZkfrbX5EBuBZs+Z142rnXfAai7VBmmvucRQ=;
        b=k/l+7EzRvmXCev0yuQZ0c5mJXHjOLfvHQv5AbXX/oUQO+o9lT3gePYJcarWNlmcpCv
         ClHFnZTbq4sfmSoo8TOlCB6tzUEW7P/5gEYXFW/YRX3Pkssb9HoAXHR4MzQS6h3cMcRV
         nsx+2eXk4NImybe1UdIJbSYaSvypRWxcmZktI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=r71azbnhZkfrbX5EBuBZs+Z142rnXfAai7VBmmvucRQ=;
        b=cqRatXSJz5ZZA7qAqkaFWBquEoU8Vqf3lv6wVvN3P/nEkQ4lRMT5Yy86oUOQIWlaZB
         GU8cjC98IMKnZ7tuou086199W3PGczvaGoN2gBsnW/lAfT4CICN5uolsi8si26RWw1Hx
         pSd7fbs9IhvHnBu84FL+zvw9EhCCcL6bLovESCyaTDvdQwEqtyXBwY8ngmACU+pgekyl
         /Wn5QqvfMiI1MMCmx3XPDm9s2Vl+w6FC4EGQoJcrz8jkw0Uxw32JOMv/stLXRAgpsM0p
         Snp5Gw824HQD/dfnSAU3JHZfKXZi1eJeAiget8RiAYbxYvIjIV3DkiaYvn0+FUDRPyMG
         8vvA==
X-Gm-Message-State: ANhLgQ3Amt6xuMxC4cNrD8knzK6dDWhoPbtrQMpKlTXMHMbgYGxtNC5k
        NnOpydMzyy04/8d168RE32TX1A==
X-Google-Smtp-Source: ADFU+vsTzsOQvgZZdj5qStX5c0xxObyeCKI3NnnQb0WpT0KdNeU7rXLEYJh4618T/wuDQOBRiFznkQ==
X-Received: by 2002:ac8:1b46:: with SMTP id p6mr12221767qtk.369.1585279946428;
        Thu, 26 Mar 2020 20:32:26 -0700 (PDT)
Received: from localhost ([2620:15c:6:12:9c46:e0da:efbf:69cc])
        by smtp.gmail.com with ESMTPSA id 199sm2629376qkm.7.2020.03.26.20.32.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Mar 2020 20:32:25 -0700 (PDT)
Date:   Thu, 26 Mar 2020 23:32:25 -0400
From:   Joel Fernandes <joel@joelfernandes.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Tejun Heo <tj@kernel.org>, Sonny Rao <sonnyrao@google.com>,
        linux-kernel@vger.kernel.org, Dmitry Shmidt <dimitrysh@google.com>,
        Amit Pundir <amit.pundir@linaro.org>, kernel-team@android.com,
        Jesse Barnes <jsbarnes@google.com>, vpillai@digitalocean.com,
        Peter Zijlstra <peterz@infradead.org>,
        Guenter Roeck <groeck@chromium.org>,
        Greg Kerr <kerrnel@google.com>, cgroups@vger.kernel.org,
        Johannes Weiner <hannes@cmpxchg.org>,
        Li Zefan <lizefan@huawei.com>
Subject: Re: [PATCH RFC] cpuset: Make cpusets get restored on hotplug
Message-ID: <20200327033225.GA250520@google.com>
References: <20200326191623.129285-1-joel@joelfernandes.org>
 <20200326192035.GO162390@mtj.duckdns.org>
 <20200326194448.GA133524@google.com>
 <972a5c1b-6721-ac20-cec5-617af67e617d@redhat.com>
 <CAPz6YkVUsDz456z8-X2G_EDd-uet1rRNnh2sDUpdcoWp_fkDDw@mail.gmail.com>
 <20200326201649.GQ162390@mtj.duckdns.org>
 <20200326202340.GA146657@google.com>
 <592d4120-0b42-4607-5efd-fb2d4d29f0cc@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <592d4120-0b42-4607-5efd-fb2d4d29f0cc@redhat.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, Mar 26, 2020 at 09:26:51PM -0400, Waiman Long wrote:
[...]
> I think the problem is that the v2_mode mount option is not that well
> documented. Maybe I should send a patch to add some some description
> about it in cgroup-v2.rst or cgroup-v1/cpusets.rst.

That is definitely worth it and I would fully support that.

thanks,

 - Joel

