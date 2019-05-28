Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F085C2CF04
	for <lists+cgroups@lfdr.de>; Tue, 28 May 2019 20:58:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727240AbfE1S6I (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 28 May 2019 14:58:08 -0400
Received: from mail-ua1-f67.google.com ([209.85.222.67]:39232 "EHLO
        mail-ua1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726463AbfE1S6H (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 28 May 2019 14:58:07 -0400
Received: by mail-ua1-f67.google.com with SMTP id w44so477511uad.6
        for <cgroups@vger.kernel.org>; Tue, 28 May 2019 11:58:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Q5FUIIyIG/0kYxdJLwvb4Tn9IP6XuPLN30cwZcfV96M=;
        b=t5RQ0PeKQ3Lf0uZs1+v6VkeIQNZAI1g50GV0MuQ5SWBbAlMESQVFP3NdID7wfxknWA
         srqzxnF3eROBqMrRzGG+IcsSoE6MHrvY3LVwQIvM6E1YX7VzSrZrRLr0HxdBf5YUMrP1
         4MwU8q4E19mju+RupN9qvqLJZ2olsaPriVJ3+lMpTzUBztcXdkjyLcXlaSDQxmylEVc3
         5H3eo4E6o4GLpAhNSvE2iQSLaomEtYaMZwRR7GaC6C2meEJvrViv+32mn1RMIUdZ2EgB
         ZYjajvJ6xzF4Adyjmyd+4UeLHFfhaJjsckQ4evZV54PQ2QeSXwaADQzR0a9+M0SF0Kjk
         c3/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=Q5FUIIyIG/0kYxdJLwvb4Tn9IP6XuPLN30cwZcfV96M=;
        b=JrOp+hWAIjksxRDpS1nfbq8UXnC2nZhSgOFT6dlRX87jSx1x36D40VqBpG5kKYz46S
         l6vL1FNR1pDqDgc0TD2/DjULHxMzbkiGKQWs+R3fO4Qj/0Gxa9h9VuuEE4WVgta2AzE8
         PK11jWQF4XaEyYCIdM/jGNzvs/vTtsfCBvDmDh0H1UMxXd/c7DiOcYvc441ldYepmyoH
         rBPVpIllCxVjPzSXpRYYsIwICvGWcPh/IHZfK/PuiAiQOmsbxY2Fy+XVIdtu2Ycsb7nX
         JdjXv2KEjqggRkEbe4MsLwuC3pOMnmM/l+weH04bAU65ipVTZKDz7gtzZkGAuJMgEIJ9
         qrtA==
X-Gm-Message-State: APjAAAUNMA5HEghBXX7dT+m3KaQl4wn/xgPUsjolV2Joa7hOr3heBqYI
        rR1JQjFOMW/bXurzeyzlxKvP55nU
X-Google-Smtp-Source: APXvYqyzIp+9V0GCnMFbyFIWbdXgxE6d38Ijb1ZUnD+N/Zsf3vRAEWz9VOM/NuvbnpIfmagxPiJwDQ==
X-Received: by 2002:ab0:2395:: with SMTP id b21mr6528154uan.108.1559069886863;
        Tue, 28 May 2019 11:58:06 -0700 (PDT)
Received: from localhost ([2620:10d:c091:500::3:d74f])
        by smtp.gmail.com with ESMTPSA id d5sm9124705vka.34.2019.05.28.11.58.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 May 2019 11:58:05 -0700 (PDT)
Date:   Tue, 28 May 2019 11:58:04 -0700
From:   Tejun Heo <tj@kernel.org>
To:     "Kasiviswanathan, Harish" <Harish.Kasiviswanathan@amd.com>
Cc:     "guro@fb.com" <guro@fb.com>,
        "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
        "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>
Subject: Re: [PATCH v2 0/4] AMDKFD (AMD GPU compute) support for device
 cgroup.
Message-ID: <20190528185804.GL374014@devbig004.ftw2.facebook.com>
References: <20190517161435.14121-1-Harish.Kasiviswanathan@amd.com>
 <20190517164937.GF374014@devbig004.ftw2.facebook.com>
 <BYAPR12MB3384A590739D7E18B736CB368C0B0@BYAPR12MB3384.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BYAPR12MB3384A590739D7E18B736CB368C0B0@BYAPR12MB3384.namprd12.prod.outlook.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hello,

On Fri, May 17, 2019 at 08:04:42PM +0000, Kasiviswanathan, Harish wrote:
> 1). Documentation for user on how to use device cgroup for amdkfd device. I have some more information on this in patch 4. 

I see.  Yeah, I just missed that.

Thanks.

-- 
tejun
