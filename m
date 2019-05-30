Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A4B30303BE
	for <lists+cgroups@lfdr.de>; Thu, 30 May 2019 23:04:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726169AbfE3VEI (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 30 May 2019 17:04:08 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:42678 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726079AbfE3VEI (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 30 May 2019 17:04:08 -0400
Received: by mail-qt1-f196.google.com with SMTP id s15so8767407qtk.9;
        Thu, 30 May 2019 14:04:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=QvB7om0vcev2wAaZ6mNs20WHEWnppnnUocSSe4PmuQc=;
        b=R+OBAIIDsIp//zF5ukSuUovTfYFEJoCkFYDnb9WiLXH8OEUgBUOh8R1UVMP2YHb3OF
         eReMh3bHTFhHiOFpIbZPL1rHF0/tIz4ay3Qv6E+WxX61iPzm6Sq8L/tCl1fC9591Rcn8
         kqtj2T9JMKOVskaMpfkZ6QK7TIZrXEBSr4ePs+hZSUnoxKdhtgqKNuoB1oHBjubmzhsT
         KaGYvH9sdz6DY7yn5Jssy8UUZ7WJkyXdsclyjAELQYnkmjwVcilDK3603hs/0AuGOMAT
         S3UDgagjoQMIyUs2GB1tFWADaSHLRMNcXQHy0YOcfEcgyb09aUl/4338+95fDdYqk13y
         gFVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=QvB7om0vcev2wAaZ6mNs20WHEWnppnnUocSSe4PmuQc=;
        b=H6TIWx0j7Z6e7u+TWiYq5Fb8MshsijsG3R0AwNDGHj9p4mXtdfN0qeZs4F8ZZIzCHm
         RPWkRmsjA694Kvn1sfmnhG1NXyA9mZ5xTH4o99TlvvB5JY7PafCN455Ctkay0xbybJvJ
         B4USv7eBERSblpBlf6A6NECe8IAK4UxEqTfre59yfJor/qZ+O37RPYp10eRTE5vuHJgp
         yLh2zvbJPUnPP6DpwndFoPrF3FuV5wK1Nv7y8ygO0dQuvigzZ8UVSKdvgspmc41FSUbs
         UcXf0eozpFUMMicMxojzR/J4OnFJK//rilLOtL55jyDlL8xcY7SlTDhYxvLO+K/XXrWH
         4u6w==
X-Gm-Message-State: APjAAAWSP9Udo/sLXdotEAdgqXQ6SJD4IGI0Qcp9S1nchYMkOLiRr+RB
        5oNZ47yXeq4+zEEXMYJc8w0=
X-Google-Smtp-Source: APXvYqyuw30OhbxT+Mwrh13RKA2Ran/Eh9ndJGKcIcll5oZCsLcDaad1o0WbLY5JhpP7ztngQo8/zg==
X-Received: by 2002:a0c:9499:: with SMTP id j25mr5385466qvj.155.1559250246854;
        Thu, 30 May 2019 14:04:06 -0700 (PDT)
Received: from localhost ([2620:10d:c091:500::1:658d])
        by smtp.gmail.com with ESMTPSA id v2sm2107944qtf.24.2019.05.30.14.04.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 30 May 2019 14:04:05 -0700 (PDT)
Date:   Thu, 30 May 2019 14:04:04 -0700
From:   Tejun Heo <tj@kernel.org>
To:     Odin Ugedal <odin@ugedal.com>
Cc:     Li Zefan <lizefan@huawei.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Corbet <corbet@lwn.net>,
        "open list:CONTROL GROUP (CGROUP)" <cgroups@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] docs cgroups: add another example size for hugetlb
Message-ID: <20190530210404.GX374014@devbig004.ftw2.facebook.com>
References: <20190529222425.30879-1-odin@ugedal.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190529222425.30879-1-odin@ugedal.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Thu, May 30, 2019 at 12:24:25AM +0200, Odin Ugedal wrote:
> Add another example to clarify that HugePages smaller than 1MB will
> be displayed using "KB", with an uppercased K (eg. 20KB), and not the
> normal SI prefix kilo (small k).
> 
> Because of a misunderstanding/copy-paste error inside runc
> (see https://github.com/opencontainers/runc/pull/2065), it tried
> accessing the cgroup control file of a 64kB HugePage using
> "hugetlb.64kB._____" instead of the correct "hugetlb.64KB._____".
> 
> Adding a new example will make it clear how sizes smaller than 1MB are
> handled.
> 
> Signed-off-by: Odin Ugedal <odin@ugedal.com>

Applied to cgroup/for-5.2-fixes.

Thanks.

-- 
tejun
