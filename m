Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 40A2D15074
	for <lists+cgroups@lfdr.de>; Mon,  6 May 2019 17:40:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726605AbfEFPk2 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 6 May 2019 11:40:28 -0400
Received: from mail-qt1-f193.google.com ([209.85.160.193]:39136 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726520AbfEFPk1 (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 6 May 2019 11:40:27 -0400
Received: by mail-qt1-f193.google.com with SMTP id y42so15204378qtk.6;
        Mon, 06 May 2019 08:40:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Z/JZRQAUubCvOOmwPXa9vzQ22nhQDYk8gbHs+6tTepg=;
        b=u7pVVXVWWeyXope1cvFsPdbqh1azIgGjmAJyXSzAwwrh4VZcnx4EH5gFy3+S4dIgPw
         rvuk1XWasLvn2RAB1cqGA4n4Pn42rLDS/nTz7oB0VY4R0UzuEifmx6bcHid1eRcLOZcc
         gxTjnES/yBuyVtEdt+fZ2h3ZA42RXU3pCgPCn8YvfKht6KVCa0Cn1DnH/pqjdE6l/x/R
         80Vq5+BTRc/X/rQl3vKMlTF+e1uyTDJYSg4XRRtCP7YpD3rtOYD9xrVu8MLTsi5RNUM8
         Lfr+nVaGmea1gc9njhmP1lbBoeWBeEiKyRoq3N19cQb6leF8p5l3FjTK93TkggBgbceq
         Brdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=Z/JZRQAUubCvOOmwPXa9vzQ22nhQDYk8gbHs+6tTepg=;
        b=Xi2CiXGcYAHjbseH9wXzIA79yEwrdqtuNJYM38V3XpbhfDdhXRtshyerN5GcN2s55s
         cu6iuUzTdBx2vTJiHQtH8ACRsdStowGoEuF2xUcMNqcmkl/APgoHaTVXy09o0wX8jYuy
         qk8QqHR/k5886ogvGbfX+K90W0gW2ihkXisa7UqgX8dAYuZjfSMYdgYBDyTuUIiIAhRy
         WxXyWOOf0HAeG80tQ3bFcjr4TFjjNai7Er4EsdEeCFcMqDwb+4oE5mMixw+BK28JmVtW
         y7EJq7cC3Tt/Apn75DePmnLPloJgKCd2qwgQGXfFsHkEagfyYF8+nr+baw3nFYTmhivt
         AbkA==
X-Gm-Message-State: APjAAAXKdmcDHZ0tqs8rU7frlKXBziaoJoZOo7zXH6dp64Bd8oeL0ycB
        Zg+kkMVtOncR6AGRQVyEiRE=
X-Google-Smtp-Source: APXvYqwriADhrMfecK4z1JVst3Y9W3mVkJA/H9252dZdqIEhAu8AgHryG+q22oiYGwFU6dCicSxMoA==
X-Received: by 2002:a0c:89c8:: with SMTP id 8mr21201893qvs.149.1557157226441;
        Mon, 06 May 2019 08:40:26 -0700 (PDT)
Received: from localhost ([2620:10d:c091:500::3:34f3])
        by smtp.gmail.com with ESMTPSA id r1sm5498369qtp.77.2019.05.06.08.40.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 06 May 2019 08:40:25 -0700 (PDT)
Date:   Mon, 6 May 2019 08:40:23 -0700
From:   Tejun Heo <tj@kernel.org>
To:     Roman Gushchin <guro@fb.com>
Cc:     Oleg Nesterov <oleg@redhat.com>, kernel-team@fb.com,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] cgroup v2 freezer follow-up patches
Message-ID: <20190506154023.GP374014@devbig004.ftw2.facebook.com>
References: <20190426175945.2559865-1-guro@fb.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190426175945.2559865-1-guro@fb.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Fri, Apr 26, 2019 at 10:59:43AM -0700, Roman Gushchin wrote:
> Hi, Tejun!
> 
> Please, pull these two follow-up patches for the cgroup v2 freezer.
> 
> These are a fix for a spurious state transition, which could happen
> due to a race condition, and a cleanup of some dead code. Both patches
> were suggested by Oleg Nesterov.

Applied to cgroup/for-5.2.

Thanks.

-- 
tejun
