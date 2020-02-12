Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BE3AD15B479
	for <lists+cgroups@lfdr.de>; Thu, 13 Feb 2020 00:06:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729103AbgBLXGm (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 12 Feb 2020 18:06:42 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:46305 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727692AbgBLXGm (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 12 Feb 2020 18:06:42 -0500
Received: by mail-qk1-f193.google.com with SMTP id u124so3328411qkh.13;
        Wed, 12 Feb 2020 15:06:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=jrnsMbO/zuCHlgaM/a/FjOvE1m1S8Xf2JYCWP8EYCzM=;
        b=j25pRrxQLvVZl/hEdj5hXOzR1QKKISX1INcpFeUQwW54ZkvXglE2Q8is0HTnPgMVhY
         +rrllujU687I53A7vCShJl/TveRHUdGZ7FLptbaNixQzozpWPI0q2u00LR0jlKDRjkuP
         d0JFMpSmy6fiaW+th1QywF2c8Kw4Qq1NGxrlOZvw6+qow4skZ3y1Ywg9vLEP/OLLL+uH
         tvDX3ICWcLknKYTPQoH6mOUomjQnTai2SXty1W3W1b0zZ35Oqj3GFmY81AZurUAiiUWR
         5zka7dCR9XMARQQxkUKkhslnuVIlmbsMgSRGtPvWpe/4ckBcScSgES52ks4wZSQK18sd
         MsTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=jrnsMbO/zuCHlgaM/a/FjOvE1m1S8Xf2JYCWP8EYCzM=;
        b=jCpO0mq4tiS60s+0tvdbwId92LqygdA0JJmgGwn0/NJwN05lbpdg1u5w//fY0E2XYv
         nlYI5m8qPwi9yQFQrc7Nxq3nnUT15QXEWjLQNJwHgd0l86bp/JyAaEMy18wfsGztu8aN
         VJOHMquqlidFbxGhXUbunYfpfZJm/HE1k24wuc1aqqSEOWmVXjTae9bw9ziOBmxMjgJr
         BQJZSl/f+7sf9hGo2wakzkBgNJ2GFb0ib74HQeXc2X/Ian4voOgZe5/or+PtM7BxR8YI
         04zyihQ51Bv1vNWhwPCnY8YOauGs2I/zgiPogaLVdstuDKbUAKGgDax3WtSm7Hz0HfVH
         UJrg==
X-Gm-Message-State: APjAAAXQ29A28l0omkOyEVFsNQP8/X90MgZJUu+cZh0BulN/yG7XhNfe
        OzjUXNGBVYGHMUXQYYwuPRY=
X-Google-Smtp-Source: APXvYqzyupirnc7FNqs6+23Z+NrOu4SQsRZxZIR/DBtolDAuCBUvyT7P4LDYC1xY7Hzx8LVsTZx3Cg==
X-Received: by 2002:a37:4894:: with SMTP id v142mr9221211qka.220.1581548801036;
        Wed, 12 Feb 2020 15:06:41 -0800 (PST)
Received: from localhost ([2620:10d:c091:500::1:985a])
        by smtp.gmail.com with ESMTPSA id b7sm224522qka.67.2020.02.12.15.06.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2020 15:06:40 -0800 (PST)
Date:   Wed, 12 Feb 2020 18:06:39 -0500
From:   Tejun Heo <tj@kernel.org>
To:     Dan Schatzberg <dschatzberg@fb.com>
Cc:     Jens Axboe <axboe@kernel.dk>, Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        "open list:BLOCK LAYER" <linux-block@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:CONTROL GROUP (CGROUP)" <cgroups@vger.kernel.org>,
        "open list:CONTROL GROUP - MEMORY RESOURCE CONTROLLER (MEMCG)" 
        <linux-mm@kvack.org>
Subject: Re: [PATCH 1/2] mm: Charge current memcg when no mm is set
Message-ID: <20200212230639.GC88887@mtj.thefacebook.com>
References: <20200205223348.880610-1-dschatzberg@fb.com>
 <20200205223348.880610-2-dschatzberg@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200205223348.880610-2-dschatzberg@fb.com>
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Wed, Feb 05, 2020 at 02:33:47PM -0800, Dan Schatzberg wrote:
> This modifies the shmem and mm charge logic so that now if there is no
> mm set (as in the case of tmpfs backed loop device), we charge the
> current memcg, if set.
> 
> Signed-off-by: Dan Schatzberg <dschatzberg@fb.com>

Acked-by: Tejun Heo <tj@kernel.org>

Thanks.

-- 
tejun
