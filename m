Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A63521743F9
	for <lists+cgroups@lfdr.de>; Sat, 29 Feb 2020 01:51:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726561AbgB2Avi (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 28 Feb 2020 19:51:38 -0500
Received: from mail-pj1-f67.google.com ([209.85.216.67]:36304 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726527AbgB2Avi (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 28 Feb 2020 19:51:38 -0500
Received: by mail-pj1-f67.google.com with SMTP id gv17so1969465pjb.1
        for <cgroups@vger.kernel.org>; Fri, 28 Feb 2020 16:51:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=M4tgEyFArklK0C2NkHJ4Ev1DbekboBTuLVXflJ8Bdmg=;
        b=YEZrilU5Emz9Z8Ec+wHK4LiI7fQQzdfCcue2M/IsGBDlntu9mx1MWRLDNRF2DkbyzK
         R2lwOWZhgB6mzNpT1Pu/aYGOixkKd67bWXduwxC7akBPX2iYuMwBeOQ5JBnJ3PoP/sm+
         fwHlgE5NWc/QcaNpgQ1v36FCjFUNaQ0QzZjXLhJBB7HSyakmk/gogoPqwcbqcHALKGWF
         LEwHUDu3Vt5k84kgM8atzhoarq3m2Hp+ubtvEsIOjJSEjTqa8HV47MN06DuHfs+WThz5
         AS+PNvVOGiAiXvalk95ELB6qY6CzHUNlqNZ8cCZ8Kyzz7tO0GspqtRYJOBiBc4omlRU0
         Jamg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=M4tgEyFArklK0C2NkHJ4Ev1DbekboBTuLVXflJ8Bdmg=;
        b=pJgQC9soda7WFKrhkKwWWd97aDooU5MlKZztEC8RDpl9jo8u0N6fLzDlq54K2V1hVe
         bH7aZC5fEuNqDxpVMiLIH9sj1gvlW9rNT/1tYqZCepEqJr5Q0HbVl+Kn1OU0RVKpxha6
         FZX0sGNu/mFdVSbsi20cr9ih0VBPKd7XYcP1E7n8qG1/gK7DRJPhl1Atidt7YqCnQJdv
         bO3H8DlBD+0GhcTJEcuGQf7JfRGWIYgh+YAyHCLBPWqTibP8J9T9XtDoulqBHAIeCmpS
         6b3Vvh8raTjZxubf8zWdk0vUn2hl7l8ITQW4b0rk+1nOV3BY2Ljq20HgyfEx3MCJ8f8K
         3QBw==
X-Gm-Message-State: APjAAAXRrYwwNLNafFmu+Gxq8gRF7AeUkAe8f7uatmcWqEO92dKMq33c
        6gZFtL7xhkDLaypfw1ddzd0WXA==
X-Google-Smtp-Source: APXvYqy82naI/lVAZlOJvZdl3C/jjyr3KkWwvalv9/HybDbYSHFf9yfSUJEYY3U/VEuNZhjYcVENGg==
X-Received: by 2002:a17:90a:8a8d:: with SMTP id x13mr7344279pjn.97.1582937496771;
        Fri, 28 Feb 2020 16:51:36 -0800 (PST)
Received: from google.com ([2620:15c:211:202:ae26:61fb:e2f3:92e7])
        by smtp.gmail.com with ESMTPSA id y16sm12339385pfn.177.2020.02.28.16.51.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Feb 2020 16:51:36 -0800 (PST)
Date:   Fri, 28 Feb 2020 16:51:31 -0800
From:   Marco Ballesio <balejs@google.com>
To:     tj@kernel.org, guro@fb.com, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, lizefan@huawei.com,
        hannes@cmpxchg.org, corbet@lwn.net, rjw@rjwysocki.net,
        pavel@ucw.cz, len.brown@intel.com, linux-doc@vger.kernel.org,
        linux-pm@vger.kernel.org, minchan@google.com, surenb@google.com,
        dancol@google.com
Subject: Re: [PATCH] cgroup-v1: freezer: optionally killable freezer
Message-ID: <20200229005131.GB9813@google.com>
References: <20200219183231.50985-1-balejs@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200219183231.50985-1-balejs@google.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hi all,

did anyone have time to look into my proposal and, in case, are there
any suggestions, ideas or comments about it?

Marco
