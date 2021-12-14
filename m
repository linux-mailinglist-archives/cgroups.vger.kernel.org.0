Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C7CA474C39
	for <lists+cgroups@lfdr.de>; Tue, 14 Dec 2021 20:45:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237506AbhLNTp5 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Tue, 14 Dec 2021 14:45:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234555AbhLNTp4 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Tue, 14 Dec 2021 14:45:56 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5BE1C061574;
        Tue, 14 Dec 2021 11:45:56 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id f18-20020a17090aa79200b001ad9cb23022so16945747pjq.4;
        Tue, 14 Dec 2021 11:45:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=WXQ4L3qp7NpGXbdQ/vd/POJH3pL/Rk5cETFAlE06wQg=;
        b=amqRniWefUWtIJ056Oy+3xDZEqFPheGvE9Orcx+F0E4zfdLvUazfQwtYHPu5kjhhAI
         ofBNdFsIW7gp8WJfw4oI/yZSbxVjS29P+EKk9S+qTHMiGxouTUqfZYmPBVgcdvqpd86h
         eaNolPyGzpGa3eWbqupzQv8eK969rcD/Bf8Cv6aXU2Clw+4iqUKy2oGW8XwlpM8s1n7c
         q7uw2Zk9YV2J56oHbmmBM8Nf6UuLo3qUo8r+Uwp3F+MRoS3Xune4T/fBXoByn2sRE0QQ
         KEJOoNUFEq/SvDfmUUp/35n53pN6BQxu7/J084YlL66sHAjS8J6XXd+m7UradoS8Ge9n
         eo+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=WXQ4L3qp7NpGXbdQ/vd/POJH3pL/Rk5cETFAlE06wQg=;
        b=V/lioLayIg6yxK0/3FaEk1h3A03u7XDZ2IiZdkvnaOlbEuIkscDfk9UpOn5YBKw7cv
         qjHzLKbr6MaAU3/VaValny9lpTX4fl9d8PCLhIzvaNopa9SQdn9KqAU+sHVQ2KgM5U88
         DKHkYcKVOYwiXuCe5sQPjBYxHB4bIkKu4ONtFyIq358RmMMJ1YwDUksVXb9bSWRMm+sS
         qrcx33t3ACgFll78urATicWTLOTi9lJ/GeyY6p3jGbOn2qKPQlm98yKRmtc4D7dvXll5
         zdVe9SmdaUqeScBSbYIMkqJWkiH44QtlcXNJ79XBRjtsEDYYNr6aSiq9JRyGUxYilt1y
         gKcg==
X-Gm-Message-State: AOAM532w2oDwyvcDfqlpqee8f/WH0JSHC7c1cwV0IFRT+mA2WDbxspvi
        OtMv3SKj3jeY+Yic8Z8cAN8XS4o6kFs=
X-Google-Smtp-Source: ABdhPJxJ4asMv9j+aC7K/2DaOHbqW56OIIjUP9y4PFtJOggcjiRcfYS3c5sBD6qydPRohZqm3kheOg==
X-Received: by 2002:a17:902:7281:b0:148:a2e8:279d with SMTP id d1-20020a170902728100b00148a2e8279dmr964608pll.164.1639511156119;
        Tue, 14 Dec 2021 11:45:56 -0800 (PST)
Received: from localhost (2603-800c-1a02-1bae-e24f-43ff-fee6-449f.res6.spectrum.com. [2603:800c:1a02:1bae:e24f:43ff:fee6:449f])
        by smtp.gmail.com with ESMTPSA id w19sm465696pga.80.2021.12.14.11.45.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Dec 2021 11:45:55 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Tue, 14 Dec 2021 09:45:54 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Wei Yang <richard.weiyang@gmail.com>
Cc:     lizefan.x@bytedance.com, hannes@cmpxchg.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [Patch v2] cgroup: return early if it is already on preloaded
 list
Message-ID: <Ybj0cicbccR2OM1I@slm.duckdns.org>
References: <20211214004607.9296-1-richard.weiyang@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211214004607.9296-1-richard.weiyang@gmail.com>
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Dec 14, 2021 at 12:46:07AM +0000, Wei Yang wrote:
> If a cset is already on preloaded list, this means we have already setup
> this cset properly for migration.
> 
> This patch just relocate the root cgrp lookup which isn't used anyway
> when the cset is already on the preloaded list.
> 
> [tj@kernel.org: rephrase the commit log]
> 
> Signed-off-by: Wei Yang <richard.weiyang@gmail.com>

Applied to cgroup/for-5.17.

Thanks.

-- 
tejun
