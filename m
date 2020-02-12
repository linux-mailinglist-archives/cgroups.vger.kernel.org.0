Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1052315B372
	for <lists+cgroups@lfdr.de>; Wed, 12 Feb 2020 23:14:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727564AbgBLWOa (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 12 Feb 2020 17:14:30 -0500
Received: from mail-qk1-f193.google.com ([209.85.222.193]:45672 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728603AbgBLWO3 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 12 Feb 2020 17:14:29 -0500
Received: by mail-qk1-f193.google.com with SMTP id a2so3691525qko.12;
        Wed, 12 Feb 2020 14:14:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=5wn2A1jq0XAt6mjZPfnCGuSlCgwymyCtNgjaq2MIIL0=;
        b=HxEDbSsr9BgQr15mCFJj3TWx3sPLSUD5N0qYHcOx8MwhQiP8y3Tk9tBhxRFMFAYY81
         hJSaxoCfVkUEYhuG6xPSj2HdgdvdQY7DBc3EBu0eP0Fvc7Ecv4/6RPLUqQUlMekefnnY
         1sK5x721YdF2+BxwX/kHdJrC6z4VFFECqzlEubpnCEVRrcIfvskSDtn4JHPwOyC1SdBv
         opFqzlqR0GqYEDFVbmCbWasZErcV1JHRWnaAzu97nTJ0JY10CfXNed1I7VoBTJgV8Idw
         WPzxiITJLJgL6k6pD4TmeGWYbAfK54WeGZ7hJtYoNiRLf/YRw6uLL6hsA2C8JIsOt2IE
         PYGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=5wn2A1jq0XAt6mjZPfnCGuSlCgwymyCtNgjaq2MIIL0=;
        b=tJkhbXd0s+3zN1cf/6gko7xum/31ZmHdD/nyzRGLSgd46eaheh1ITPL3IPT5enaIOB
         kCdIPn9nSyb9aEh2aAeCx1mUlrt+Y6JDimPQ7AQoVFlyQ4JjSekYxv/If6tApWULbUew
         LHsO1Jd1z0iBM7XK3jr8eZsdIz9+S9NplXknPs8cYtQ8UalrXlcekBJ8nLlD3p6PnU7u
         3DkDq0ErADeVp9v2fjsYckkv1zHoshijt8zyUOgT6yWUvIyZrWfqt8svuuse/zKe16bZ
         Cx5eJghUAxtOi8VUct9Hp3MqBL47mvVYnbsjrOJNXZ3sDCEGQ7IN8TB2LOO1c+hTtboG
         cM8A==
X-Gm-Message-State: APjAAAUksVU6rFAQ8covPyC6hk54Egz94OvIXTdFiTD+8mKE6PtWrC0b
        DrcbfZN0sbWK5DMwWEl1wmI5jSlwfIM=
X-Google-Smtp-Source: APXvYqxBrptXhkwFDgbeO/elgSRqVvK1OUQEDwSn8e9zYFd9G4ZZNllDzPAQIM5TSnUFGy9G6B1WVw==
X-Received: by 2002:ae9:eb49:: with SMTP id b70mr10802147qkg.307.1581545668777;
        Wed, 12 Feb 2020 14:14:28 -0800 (PST)
Received: from localhost ([2620:10d:c091:500::1:985a])
        by smtp.gmail.com with ESMTPSA id p19sm284083qte.81.2020.02.12.14.14.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2020 14:14:28 -0800 (PST)
Date:   Wed, 12 Feb 2020 17:14:27 -0500
From:   Tejun Heo <tj@kernel.org>
To:     Prateek Sood <prsood@codeaurora.org>
Cc:     peterz@infradead.org, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cpuset: Make cpuset hotplug synchronous
Message-ID: <20200212221427.GK80993@mtj.thefacebook.com>
References: <1579878449-10164-1-git-send-email-prsood@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1579878449-10164-1-git-send-email-prsood@codeaurora.org>
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri, Jan 24, 2020 at 08:37:29PM +0530, Prateek Sood wrote:
> Convert cpuset_hotplug_workfn() into synchronous call for cpu hotplug
> path. For memory hotplug path it still gets queued as a work item.
> 
> Since cpuset_hotplug_workfn() can be made synchronous for cpu hotplug
> path, it is not required to wait for cpuset hotplug while thawing
> processes.
> 
> Signed-off-by: Prateek Sood <prsood@codeaurora.org>

Applied to cgroup/for-5.7.

Thanks.

-- 
tejun
