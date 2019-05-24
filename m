Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8331D2A097
	for <lists+cgroups@lfdr.de>; Fri, 24 May 2019 23:44:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404248AbfEXVoP (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 24 May 2019 17:44:15 -0400
Received: from mail-vk1-f169.google.com ([209.85.221.169]:38707 "EHLO
        mail-vk1-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404176AbfEXVoP (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 24 May 2019 17:44:15 -0400
Received: by mail-vk1-f169.google.com with SMTP id p24so2549621vki.5;
        Fri, 24 May 2019 14:44:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=ppYQMWAvPPPHzjUYhTAXcRClz6zmn//kA8Gna2puNdM=;
        b=iCLh9A/cXLCJu2cYrfO+D02D9JZCWjOPfABYzSpzSnzvw+iM+O0nFXo9bOFy4NoG35
         6tGwLsX1stvp9Fj1cZi6gDDlt4vQF2vczIeIiQFnLylhzPc0M03zMQ1sks0SjMfDuTkz
         718ibMT8MzmQYgwSzJosjqZXGmhF1KWLLrjQO1GdHBOP4nUOg4VvJPDcTr51s4LGjXek
         4wCuKnt1wVE7yNsEE+jaHVwNP7/lz1UcPqN4zRMUKLCPQxHEdfzqgv32V6RhbzGHkC9A
         +8rorSl29HWTk+xcTrT+17IWJ0FuA7sFzaY0rJzrpFc3FWfcUQ5KRh6mChaNxRiybqz2
         7NXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=ppYQMWAvPPPHzjUYhTAXcRClz6zmn//kA8Gna2puNdM=;
        b=UMDYOQtrB/ACHmjOmj4MjmJUylnRQjo3/CpevjC3KwRlwnZPRJRl2K5I4aHyg76UZI
         a8nPK98tLs5q3pUNExqL3EJh49jr8gVVXWLUItr0j7jAFXsznZBheidvrznxRhvvpYvb
         SUSB+SaU18yRxlK/UsaW7PMbdXENmRprJeFyKVwSLj5R4UR0cG1EPi2Ng49ZFGshEb+w
         kDfptoCbvMWnleRSQpRwpJvVwKMh3bpB5Gn0szZAuIK7JXM6urGOFor3p5W0lbguimJr
         VettBU7FVKxXNmt/BBrRIKJi0NcgtwMwigaQ3rrx+XgQd8rKIKFjSBuNi08wTOyRqsVE
         nGtA==
X-Gm-Message-State: APjAAAXHTgljn1fNAwcGp86L/Y13mjYMCNJ/dGQPutmtgaOgzgeOTzQU
        hWO9WsGPfqBxcfT/VFj/dzs=
X-Google-Smtp-Source: APXvYqz8Q+5EOwArJXYcxB42iNP/7jC6QHkeqJ960QLp/YsSo4VPosPZyy+KSbDmHVRWANDCqIBz9g==
X-Received: by 2002:a1f:8ad0:: with SMTP id m199mr8096355vkd.80.1558734254307;
        Fri, 24 May 2019 14:44:14 -0700 (PDT)
Received: from localhost ([2620:10d:c091:500::1:36ab])
        by smtp.gmail.com with ESMTPSA id v133sm2586461vkv.5.2019.05.24.14.44.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 24 May 2019 14:44:13 -0700 (PDT)
Date:   Fri, 24 May 2019 14:44:12 -0700
From:   Tejun Heo <tj@kernel.org>
To:     Xuehan Xu <xxhdx1985126@gmail.com>
Cc:     ceph-devel <ceph-devel@vger.kernel.org>, cgroups@vger.kernel.org
Subject: Re: Fwd: [PATCH 1/2] cgroup: add a new group controller for cephfs
Message-ID: <20190524214412.GH374014@devbig004.ftw2.facebook.com>
References: <20190430120534.5231-1-xxhdx1985126@gmail.com>
 <CAJACTuczjByPgDmBb1vgPdX5U0LWhygVNzRS+VPXt3ZSEo+eTQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJACTuczjByPgDmBb1vgPdX5U0LWhygVNzRS+VPXt3ZSEo+eTQ@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hello,

On Thu, May 23, 2019 at 02:33:46PM +0800, Xuehan Xu wrote:
> From: Xuehan Xu <xuxuehan@360.cn>
> cgroup: add a new cgroup controller dedicated to cephfs client ops limiting
> 
> this controller is supposed to limit the metadata
> ops or data ops issued to the underlying cluster.
> 
> Signed-off-by: Xuehan Xu <xuxuehan@360.cn>

Can you please elaborate why ceph needs its own controller?

Thanks.

-- 
tejun
