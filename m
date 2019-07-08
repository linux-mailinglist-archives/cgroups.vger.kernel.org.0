Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 690F662725
	for <lists+cgroups@lfdr.de>; Mon,  8 Jul 2019 19:31:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728708AbfGHRbk (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 8 Jul 2019 13:31:40 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:36013 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726997AbfGHRbk (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 8 Jul 2019 13:31:40 -0400
Received: by mail-qt1-f193.google.com with SMTP id z4so15385399qtc.3;
        Mon, 08 Jul 2019 10:31:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=F3Z8ODmIuThf6qIMsRJ9IwagYSAnPtGl9RN+7VHHChg=;
        b=aqE1xvZMtT7tlMKN0uI2aPhS+B7q7NPQx57ZzTXE3rm2BGvJMUQYHZdGbsSR+ZNHfg
         KfCyif2Z5T+CAzVEI8+uNEiuZ86jaLvvcnbumD1DftZwskChw61iCaejgttVDYeo+puX
         EMcYe4mqQRkut1balpM3jphqF+6LvTpJVgsDGjeKNcaL2HrtEEceP6faQACtVF2GbCnH
         EnfW9OChjLrUTnLaic14bALWa2BZWvwWjb4HbOhssw6ZZDbanIOucVyKb3DXFQID3zzN
         6PaxqH4Gy69wl4Cd+/ST6a+M1Yks+kZdteW72v8EtAfrgEC6A0/zqxo7tvMMEc0VlKUl
         /AcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=F3Z8ODmIuThf6qIMsRJ9IwagYSAnPtGl9RN+7VHHChg=;
        b=BVMfdo+CNJi8nbWz7KKml47a5Goq8IzdzN0kmr9EBWQqncPfGlMzMqYUowBqKdGVeB
         8qdt6Nv3z5pXjJ6szNvoLpLjfjntkeIHN0cL1sAfyrHjvgNFHfpLdXJbNN8mI0xIrz+O
         aRJ1MnkGgFn6Spd4pH1LFcH8ipprfkPUprraD3Nvpkr1XLOu3YFbIJla7NWEIlFA5RRd
         XN2B8/PvPhBU+LzACo3M7ruKrnk78u5CC7xqfIoHBCcyaJKZzvjv2IL+6fcxtfvUse11
         5VqHPUqaRUbuOIHDSzp9LZ1KfAtJJ11rJDqgbNu57uh6IEdIdA/vZPbjYkrCzVJQ33mt
         1cIA==
X-Gm-Message-State: APjAAAU9IjvhyNawQP2RDl2yx19ZZI1iChyKlUqO6Z5IsyuoFh1h2KBO
        oTn1wYTf1WuRwKBNnJXS8Ro=
X-Google-Smtp-Source: APXvYqzGrhEv1gxKVd1/9J9mYvxXMWJHhzWdHoqmqPs9JYDKKxlkOivbY+dTn6S37VhKMXYfjeiwoA==
X-Received: by 2002:aed:2d67:: with SMTP id h94mr10495706qtd.154.1562607099035;
        Mon, 08 Jul 2019 10:31:39 -0700 (PDT)
Received: from localhost ([2620:10d:c091:500::2:fa50])
        by smtp.gmail.com with ESMTPSA id m44sm8984785qtm.54.2019.07.08.10.31.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Jul 2019 10:31:38 -0700 (PDT)
Date:   Mon, 8 Jul 2019 10:31:37 -0700
From:   Tejun Heo <tj@kernel.org>
To:     Roman Gushchin <guro@fb.com>
Cc:     Peng Wang <rocking@whu.edu.cn>,
        "lizefan@huawei.com" <lizefan@huawei.com>,
        "hannes@cmpxchg.org" <hannes@cmpxchg.org>,
        "cgroups@vger.kernel.org" <cgroups@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] cgroup: minor tweak for logic to get cgroup css
Message-ID: <20190708173137.GH657710@devbig004.ftw2.facebook.com>
References: <20190703020749.22988-1-rocking@whu.edu.cn>
 <20190708164243.GE657710@devbig004.ftw2.facebook.com>
 <20190708172944.GA24662@tower.DHCP.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190708172944.GA24662@tower.DHCP.thefacebook.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Mon, Jul 08, 2019 at 05:29:49PM +0000, Roman Gushchin wrote:
> On Mon, Jul 08, 2019 at 09:42:43AM -0700, Tejun Heo wrote:
> > On Wed, Jul 03, 2019 at 10:07:49AM +0800, Peng Wang wrote:
> > > We could only handle the case that css exists
> > > and css_try_get_online() fails.
> > 
> > As css_tryget_online() can't handle NULL input, this is a bug fix.
> > Can you please clarify that in the description?
> 
> -       if (!css || !css_tryget_online(css))
> +       if (css && !css_tryget_online(css))
> 
> If css == NULL, !css is true, and the second part of the || statement
> will not be evaluated. So it's not a bug fix.

Ah right, it's just confusing.  Will apply after the merge window.

Thanks.

-- 
tejun
