Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 70BC810A3C5
	for <lists+cgroups@lfdr.de>; Tue, 26 Nov 2019 19:02:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725933AbfKZSCs (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 26 Nov 2019 13:02:48 -0500
Received: from mail-qt1-f194.google.com ([209.85.160.194]:42785 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725870AbfKZSCs (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 26 Nov 2019 13:02:48 -0500
Received: by mail-qt1-f194.google.com with SMTP id g19so2179635qtv.9
        for <cgroups@vger.kernel.org>; Tue, 26 Nov 2019 10:02:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=cwQp7AqmSXIeb7fdNfHZjTtXCBdMcaSZdBygP+G2Aw8=;
        b=stvr/5Y1szio8vcbiQSI3hKF0iiuJiVZC+t/UkR/niYw96GFE1i00Uy1kWc7RGal8I
         d3PiB8cSLMtJjaL2A5vZJRCqUkjNH12TyoRUKo8jIcX1HJTIzzj/guJLgx77Rvox9Gtf
         3JcMkOJvZ6T6TxZwK0AILUekYnBTzlnEEkB5stoHC8RVBYzWgUH2kqvVvuzm5e0CjnPw
         wEnOZ+YfNL3mH0IB5VzJAxh7saOX27HqVHGAtkmod2MHu7u6YtwfrJ8t4XeNobDIsBnw
         jp1u1+a9v6Fg1UEuls3aMyoDeRSgOPlm+VIPxZKJenVkyh/roxuJkX5cqViLMQaODHuE
         Qa6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=cwQp7AqmSXIeb7fdNfHZjTtXCBdMcaSZdBygP+G2Aw8=;
        b=UJSMHdN+QfZdYTPkHcviN/S/Hsgk58az8Tn8j4skitFofR2fASsG0LBfDm+WhnS8dw
         taQJA84RodOWqTK+jo/fXHnJ/Vw7skIq00QXiaesmmdxC06T4EBPa2Z2b0pk5auo/hTV
         4VfB6H+tQ8IWwKx4jEQy91NkKMzRehEgWHCM3T7SUMGRPiYft1y64a4+UFQpxfAab5gK
         +MU1zTm3BNgzO8y12MdYQ9PgDaOG1cq++vKFwA53q+Y6kF5/f5XNMICnQObvCIlZOxsO
         iX5TA91dJf7QC3X4WpfduxTzyX6S/yKW6OABuNPPgwH3mgj0J6F1PSK2IDadO4n7vdFY
         U7vg==
X-Gm-Message-State: APjAAAUz+6GZYZuHx0f9djrdwL5+v0gP/IU0EOJun9lJ6KQ7YFzVJivh
        NBmBy03YeSQ4MtD11S34EPg=
X-Google-Smtp-Source: APXvYqztbTcbtSRIEa2oTTNSCpb2NFE8z2Fpp0f/JvPbqJ+ok4wKof+vzU4pwz/TY6QmrD66qqjL2g==
X-Received: by 2002:ac8:7202:: with SMTP id a2mr33040000qtp.247.1574791367023;
        Tue, 26 Nov 2019 10:02:47 -0800 (PST)
Received: from localhost ([2620:10d:c091:500::2:a515])
        by smtp.gmail.com with ESMTPSA id y21sm5566563qka.49.2019.11.26.10.02.46
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Nov 2019 10:02:46 -0800 (PST)
Date:   Tue, 26 Nov 2019 10:02:44 -0800
From:   Tejun Heo <tj@kernel.org>
To:     Giuseppe Scrivano <gscrivan@redhat.com>
Cc:     cgroups@vger.kernel.org, mike.kravetz@oracle.com,
        lizefan@huawei.com, hannes@cmpxchg.org, almasrymina@google.com
Subject: Re: [PATCH] mm: hugetlb controller for cgroups v2
Message-ID: <20191126180244.GD2867037@devbig004.ftw2.facebook.com>
References: <20191121211424.263622-1-gscrivan@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20191121211424.263622-1-gscrivan@redhat.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hello,

On Thu, Nov 21, 2019 at 10:14:24PM +0100, Giuseppe Scrivano wrote:
> .failcnt and .max_usage_in_bytes are not provided as single files

Please drop max_usage_in_bytes and make failcnt .events::max for
consistency.

Other than that, looks good to me.

Thanks.

-- 
tejun
