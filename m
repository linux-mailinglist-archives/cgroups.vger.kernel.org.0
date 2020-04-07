Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 363AB1A0E72
	for <lists+cgroups@lfdr.de>; Tue,  7 Apr 2020 15:35:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728869AbgDGNfY (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 7 Apr 2020 09:35:24 -0400
Received: from mail-qk1-f195.google.com ([209.85.222.195]:39580 "EHLO
        mail-qk1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728482AbgDGNfY (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 7 Apr 2020 09:35:24 -0400
Received: by mail-qk1-f195.google.com with SMTP id b62so1587474qkf.6;
        Tue, 07 Apr 2020 06:35:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=odzEhtuT1mkH5cv+06XvJ0mo1X9dWs4O45m8red/YFE=;
        b=lLPy54IqRiVI+gbF9bXttpMrnAgkCN0tMMlu1yiVIlS2/nkavZOJukt5viyskCkZCp
         /a3SWshrpdGsMCXv86eLzNPxbhRKSq1M1Ot/P5T8kc+zlZg61ebkbREN6INJiTb9T/nd
         bnWH7iDmLuseRsFocSas0ZOCT1ZaGSfA8inB2kUB37Q0d++qtW3YXbb6oyUtpgmgRj4B
         Ag0sQG+/+CRN2rKLdq+v2y00f8KGMwhdteP1POMgqhxUMBoefVpWT42aNaOUUb/cTIFw
         gWOHqN/gsvLlUHfCdmtSVn+SNDRwcyPuDSBY5pHYyLlkWMElV+QQ+GpDCw1CYnZ1hXk4
         gGXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=odzEhtuT1mkH5cv+06XvJ0mo1X9dWs4O45m8red/YFE=;
        b=jepqtQPF9DWDGySZZdgJM9Gavkslj+uAIWAq2pC41CjWoQhMNaDlarPPZ6k5hpHNM9
         nTKKkZiyUyCb5gw/g0CYw4xxUYLVbFNbMGMZvMFGW/0URbRFuM2Nc2oJoVk4O+6TxJAN
         OANLdArJgH6/FYAk5aa7CBrE7VMvKbsqejH/BDoGiTPS75bhV5PK+7LI3cxcFtznirQU
         f72A2HZyBM5yIGkRTrkaEIj6OW63ZaoYgX+TI6e6yGmPPdd0x+9XkDJxWjgOSUbmhe3b
         pmi9BAv8LxQcZjTUIQSOKiWVw0Sno8pfYqbbSSs/08qiZZ0KNdaa9ciRiMyLm4cnLkj3
         ZnQA==
X-Gm-Message-State: AGi0PuZtfMJVetA2jXrpHyt+CsyXLaxDQ/fBmzsCRVZef3WXF8bpgjRp
        nOLL2hEHibl8miZdfdptxBI=
X-Google-Smtp-Source: APiQypLEqD0fQclX3tUCPeigphzqR8Cy8D/rzw25UKOBzyLv8uRQqnVSNxgvxJozLd7DoX9+FIVO+A==
X-Received: by 2002:a37:670a:: with SMTP id b10mr2205766qkc.342.1586266522385;
        Tue, 07 Apr 2020 06:35:22 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::ceda])
        by smtp.gmail.com with ESMTPSA id a19sm16799360qtp.5.2020.04.07.06.35.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2020 06:35:21 -0700 (PDT)
Date:   Tue, 7 Apr 2020 09:35:20 -0400
From:   Tejun Heo <tj@kernel.org>
To:     Qais Yousef <qais.yousef@arm.com>
Cc:     Qian Cai <cai@lca.pw>, Prateek Sood <prsood@codeaurora.org>,
        Li Zefan <lizefan@huawei.com>, cgroups@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: Deadlock due to "cpuset: Make cpuset hotplug synchronous"
Message-ID: <20200407133520.GI162390@mtj.duckdns.org>
References: <F0388D99-84D7-453B-9B6B-EEFF0E7BE4CC@lca.pw>
 <20200325191922.GM162390@mtj.duckdns.org>
 <20200326101529.xh763j5frq2r7mqv@e107158-lin>
 <20200403145523.GC162390@mtj.duckdns.org>
 <20200406105522.c66p4vzzzylety5d@e107158-lin.cambridge.arm.com>
 <20200406143405.GH162390@mtj.duckdns.org>
 <20200407130725.jhtth3bneo33zex6@e107158-lin.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200407130725.jhtth3bneo33zex6@e107158-lin.cambridge.arm.com>
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Apr 07, 2020 at 02:07:26PM +0100, Qais Yousef wrote:
> On 04/06/20 10:34, Tejun Heo wrote:
> > On Mon, Apr 06, 2020 at 11:55:23AM +0100, Qais Yousef wrote:
> > > What would be the right approach to get a fix in then? We have been skipping
> > > this test for a while and we'd like to enable it but this failure is a
> > > blocking issue.
> > 
> > Update the test so that it accounts for the async nature of the operation?
> 
> With a sleep() between the hp ops and the read? Isn't this a nasty hack?

Some operations are just async. Why is that inherently wrong?

> I was just trying to find out what can be done for 5.7. But based on your
> response this is sadly a dead end. For no reason I can comprehend.

Because it's creating real issues while trying to address a non-real problem.
It's dumb. Fix the non-real part.

Thanks.

-- 
tejun
