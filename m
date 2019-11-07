Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3C572F338B
	for <lists+cgroups@lfdr.de>; Thu,  7 Nov 2019 16:40:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387561AbfKGPkQ (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 7 Nov 2019 10:40:16 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:39313 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726810AbfKGPkQ (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 7 Nov 2019 10:40:16 -0500
Received: by mail-qk1-f194.google.com with SMTP id 15so2352822qkh.6
        for <cgroups@vger.kernel.org>; Thu, 07 Nov 2019 07:40:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=mm2/epRihIKWPzX981ZQ74VuNWr9mY2U9BJpefxbeoA=;
        b=mm1pXS2UQNFqUv4FCXd+L3asjqhVc3jTaOC3EGc9U2Yc9E9kAhPeqiRs9xSSjJtGZu
         eYDiJh4Tpm012lg5Dv4NqQ7xFAUVE45hbj+ZPGXu5QIQ9BoJ0/wCub6+Az7m6N8OyXeW
         418VaXb2RC2lNuDF4UPxMu3QFw6YjoqHp6d8JdTKU8xNtAh5vYUFKSXqwCyfinO4RmzR
         6LMv0SRN/GmedM2Uq3dKpHcT+scsdi+9AfNAC4JgTguTfKJvcE7WdD5zTHjtrWljHW4h
         mVze6C4iue7GFr9DusGAt0zkQcNC6OIfuX5SlS2HcC16fEf/iBT6RBoToKRg0jKDwliZ
         bE4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=mm2/epRihIKWPzX981ZQ74VuNWr9mY2U9BJpefxbeoA=;
        b=Dizocmozd6qPsQFmQf3sE2QTPjRkMbhC/+7UyeGyMQ+kQ0jEliFHJEQPH6PHa9+eM7
         ZpZNHegjDrAvhi071S+am+IQMdIXSw4361gnfv/cmTELq8uKwgTDuEYHy95dbz7PXkIb
         kJ0p4qLd70RXgVUrZCjSTkgWSmKKv3F6NZueC30dmK/hZqZz85hCG+6iJzgbslA9+AX4
         DwePJOsShtEbaZ7JpIqIsSRXSV+vULK/i5s1PdkxAMQxL52tTs+2w2XgGxEcPThln2bv
         rvTKL/IuelsNLts+OGEGB6jJNispWy+E7JXAOs3uBO01w7HtYh1ocjN4a/TrCaJN+Tbr
         THtg==
X-Gm-Message-State: APjAAAXp0vLXDe5hWImYxmba/P4FY3SGcAkKD/L8o7lYE00bEzlQvgyT
        t5y6iC2+8SKQigtRelLxFY0=
X-Google-Smtp-Source: APXvYqz+D6TKPFiN62hkvkIxGSX13hn4vWM00CxNz+vxr6fQCE09iuSfBF0oUYc4U6nNux3ly3s9GQ==
X-Received: by 2002:a37:4716:: with SMTP id u22mr3411242qka.495.1573141215122;
        Thu, 07 Nov 2019 07:40:15 -0800 (PST)
Received: from localhost ([2620:10d:c091:500::2:3f13])
        by smtp.gmail.com with ESMTPSA id i4sm1228270qtp.57.2019.11.07.07.40.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Nov 2019 07:40:14 -0800 (PST)
Date:   Thu, 7 Nov 2019 07:40:13 -0800
From:   Tejun Heo <tj@kernel.org>
To:     Honglei Wang <honglei.wang@oracle.com>
Cc:     lizefan@huawei.com, hannes@cmpxchg.org, cgroups@vger.kernel.org,
        guro@fb.com, oleg@redhat.com
Subject: Re: [PATCH v2] cgroup: freezer: don't change task and cgroups status
 unnecessarily
Message-ID: <20191107154013.GW3622521@devbig004.ftw2.facebook.com>
References: <20191030081810.18997-1-honglei.wang@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191030081810.18997-1-honglei.wang@oracle.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, Oct 30, 2019 at 04:18:10PM +0800, Honglei Wang wrote:
> It's not necessary to adjust the task state and revisit the state
> of source and destination cgroups if the cgroups are not in freeze
> state and the task itself is not frozen.
> 
> And in this scenario, it wakes up the task who's not supposed to be
> ready to run.
> 
> Don't do the unnecessary task state adjustment can help stop waking
> up the task without a reason.
> 
> Signed-off-by: Honglei Wang <honglei.wang@oracle.com>
> Acked-by: Roman Gushchin <guro@fb.com>

Applied to cgroup/for-5.5.

Thanks.

-- 
tejun
