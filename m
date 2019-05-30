Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AE8222F785
	for <lists+cgroups@lfdr.de>; Thu, 30 May 2019 08:45:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727444AbfE3Go4 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 30 May 2019 02:44:56 -0400
Received: from mail-pf1-f193.google.com ([209.85.210.193]:37599 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725961AbfE3Goz (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 30 May 2019 02:44:55 -0400
Received: by mail-pf1-f193.google.com with SMTP id a23so3325181pff.4
        for <cgroups@vger.kernel.org>; Wed, 29 May 2019 23:44:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chrisdown.name; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=OtJUoXoSDr8VsqZMlQCV4tuhz5lMclRWprZBC+48UZI=;
        b=XUEorjCrLN9OrKuTIaR8sqQcataBFWGo19e2lBEQq/O74XS3Rv/gHEewD1Xhxg87dF
         Li12khbvVst/JlwygCiwvAhusNa3tSQFd4Sci5NEM5LIDG4i1O/IuqU4NCA4JrjyTjI5
         Z8e+mv6BlLgw2Wij6fVvKbwpyso+4TBaM01wI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=OtJUoXoSDr8VsqZMlQCV4tuhz5lMclRWprZBC+48UZI=;
        b=SOuR3YwXAwYOH4zUcQ9MbCJpApTNjjAgnXAw+7GdHEmUlOuDVxJHWC1QKHSmh6sid2
         FYs33nNZ1pWi6Cw1G2/XLNqIV9g8YWkpWVRHOs7gippnp1fyTdUiw3upW5swRYWpsPeN
         AbYYnGjfugFzOrzHnuTHGioc7WOP45PmeXsTRDw2YH/fsAR+8eNXcQfsIMKr0TRckv46
         s8++tv+7DCEVtqcfdDBxfSm6ttaBV959GcLPXPtxQH8VYus5zaRg0XYltqkouQre1HNf
         tM1iDndlrZhWYJxIWT71qR5Nf7Ox1hr0QZJvCs544CP8kdqH8SpFXeTLArPCSHTaVLSy
         KA2g==
X-Gm-Message-State: APjAAAW34xhlxa6j4rTSZsFNOpAdgtq43VF0iUfVli9xW5+WD/1xMQEE
        KPtbxemuB6Mv/mKhxRGZjH0gpw==
X-Google-Smtp-Source: APXvYqyoyOiL1g0uw5EVCPG0xAn0ze5ad3M0tRvk7mVR1v4xGNiEEXjkXPCgkCattXKsglAopRzh3g==
X-Received: by 2002:a17:90a:8089:: with SMTP id c9mr2007919pjn.68.1559198694988;
        Wed, 29 May 2019 23:44:54 -0700 (PDT)
Received: from localhost ([12.15.241.26])
        by smtp.gmail.com with ESMTPSA id x1sm1242193pgq.13.2019.05.29.23.44.54
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 29 May 2019 23:44:54 -0700 (PDT)
Date:   Wed, 29 May 2019 23:44:53 -0700
From:   Chris Down <chris@chrisdown.name>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Tejun Heo <tj@kernel.org>, Roman Gushchin <guro@fb.com>,
        Dennis Zhou <dennis@kernel.org>, linux-kernel@vger.kernel.org,
        cgroups@vger.kernel.org, linux-mm@kvack.org, kernel-team@fb.com
Subject: Re: [PATCH REBASED] mm, memcg: Make scan aggression always exclude
 protection
Message-ID: <20190530064453.GA110128@chrisdown.name>
References: <20190228213050.GA28211@chrisdown.name>
 <20190322160307.GA3316@chrisdown.name>
 <20190530061221.GA6703@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20190530061221.GA6703@dhcp22.suse.cz>
User-Agent: Mutt/1.12.0 (2019-05-25)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Michal Hocko writes:
>Maybe I am missing something so correct me if I am wrong but the new
>calculation actually means that we always allow to scan even min
>protected memcgs right?

We check if the memcg is min protected as a precondition for coming into this 
function at all, so this generally isn't possible. See the mem_cgroup_protected 
MEMCG_PROT_MIN check in shrink_node.

(Of course, it's possible we race with going within protection thresholds 
again, but this patch doesn't make that any better or worse than the previous 
situation.)
