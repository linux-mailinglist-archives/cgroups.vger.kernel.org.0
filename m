Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0337215051
	for <lists+cgroups@lfdr.de>; Mon,  6 May 2019 17:34:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726118AbfEFPeQ (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 6 May 2019 11:34:16 -0400
Received: from mail-qt1-f174.google.com ([209.85.160.174]:43474 "EHLO
        mail-qt1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725994AbfEFPeP (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 6 May 2019 11:34:15 -0400
Received: by mail-qt1-f174.google.com with SMTP id r3so5287164qtp.10
        for <cgroups@vger.kernel.org>; Mon, 06 May 2019 08:34:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=YSziFhJ3qYvRfC9wQNLoFY0MIXeSPQ6k5UAtmt8K1qM=;
        b=Mgsuo5Qg7EtYDJLjf1ElLBbszRsrgJ68PzRPiyDd7SYXdt9nKefWk+UsrdL4TjgXMd
         ShiML8XhP+T+h1tU5OmzvEbWIw1F7b/fIUIF1rKRiyrgl5d2zusfagsdULyA1duXKWVP
         6PxsU/YgGt5WET9rVHaIHireOHz9KOnkOPOf8i6BJzM2m4VGZ3GYDqF4y44fBkZDNtQc
         Guv6X82QZuVt+5UN4BXMAmCDEkzrYyYHzuq8w3kFXMBICb7T+A/KAL2bCaUMW5Z9wqth
         VPHHB9OpgHVqyaRF7s0nTKXsBpzlV6oA96/xNo5xAi/l4LQO+jiAOMAUvofNcUoUmpt8
         nf+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=YSziFhJ3qYvRfC9wQNLoFY0MIXeSPQ6k5UAtmt8K1qM=;
        b=qANFJeoCSEDBn1/qKQPp29Lkz582e6oQW9TwPfPF8SZNCeEfaBUTUG/2/1fullpMtd
         sX/cNPS9YbjtTVsoQ3AzRF0cl1eOdcy1Pr5PaQazJ/wN/SPLD9BNsyZ9Za7CbBSfz/By
         iT10tb4U9WCK1/mvOpF6094bnBtKg2tITEIBtAjH10bwjvrD0uGlj3kMLbZWPV+SZNCL
         fGUhkyjj93wiXoUU1o0RGmhC8lTt5r6PMAHs+CSazl/dji7W8qiL51p4n6xznFOrr5+f
         M6RsQX/E608qSIfaB2ypS7OEi57dnR0epnQMG9BqXDod6Ao/BIfs7Mw//b0N6BuGFyug
         NOrw==
X-Gm-Message-State: APjAAAUp5lj7JwJSTXpg0oluWRTqU2064uqEj0hqFyirMwYbm9SCrUl9
        qfvy/5aqkYr91wMqcHQmcx8=
X-Google-Smtp-Source: APXvYqyUfhljddRcliO1W2WADj2qIe/wet9CdqW7vsMjaI6zjxJzGOiDnxeMb5fxByc+rSk7O5icEw==
X-Received: by 2002:a0c:9004:: with SMTP id o4mr21231179qvo.175.1557156855091;
        Mon, 06 May 2019 08:34:15 -0700 (PDT)
Received: from localhost ([2620:10d:c091:500::3:34f3])
        by smtp.gmail.com with ESMTPSA id k89sm6283812qte.33.2019.05.06.08.34.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 06 May 2019 08:34:13 -0700 (PDT)
Date:   Mon, 6 May 2019 08:34:12 -0700
From:   Tejun Heo <tj@kernel.org>
To:     Shaokun Zhang <zhangshaokun@hisilicon.com>
Cc:     cgroups@vger.kernel.org, Roman Gushchin <guro@fb.com>
Subject: Re: [PATCH -next] cgroup: Remove unused cgrp variable
Message-ID: <20190506153412.GN374014@devbig004.ftw2.facebook.com>
References: <1556618249-56304-1-git-send-email-zhangshaokun@hisilicon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1556618249-56304-1-git-send-email-zhangshaokun@hisilicon.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Tue, Apr 30, 2019 at 05:57:29PM +0800, Shaokun Zhang wrote:
> The 'cgrp' is set but not used in commit <76f969e8948d8>
> ("cgroup: cgroup v2 freezer").
> Remove it to avoid [-Wunused-but-set-variable] warning.
> 
> Cc: Roman Gushchin <guro@fb.com>
> Cc: Tejun Heo <tj@kernel.org>
> Signed-off-by: Shaokun Zhang <zhangshaokun@hisilicon.com>

Applied to cgroup/for-5.2.

Thanks.

-- 
tejun
