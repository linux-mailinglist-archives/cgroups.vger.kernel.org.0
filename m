Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2626515B370
	for <lists+cgroups@lfdr.de>; Wed, 12 Feb 2020 23:12:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728185AbgBLWMw (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Wed, 12 Feb 2020 17:12:52 -0500
Received: from mail-qk1-f194.google.com ([209.85.222.194]:36713 "EHLO
        mail-qk1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727564AbgBLWMw (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Wed, 12 Feb 2020 17:12:52 -0500
Received: by mail-qk1-f194.google.com with SMTP id w25so3752284qki.3;
        Wed, 12 Feb 2020 14:12:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=htZSNJ3oIZAPreJh5xh8HpLPmxowkMMDY5AHwsIFPU4=;
        b=JgbLnHXZBEJ6fny9Cf39uzWywqhTZCEc9XA7HjonBYcbbBVxey3E8jGB1bPKWVrUdH
         MDi2aKPGMfYktEAwxum6w8vAcuQKbRKfvpUwLIGwLk3/YmeHtcygHekDiNYf5+9Q3/ti
         zacH6LhE208pGea8c9ESgsdYtAeXB4ezKvDfBqcv9jlPHtgoFYltXKi/V/yrcVbYwnku
         X3bNAPwE8YMLtOxeeS52qw2JNI4UFj3sP6w3f4vVctpZ6uj6fLe0Dq1xLddiXOyyjYKa
         A7dAQszw4h0EP/fqdq1NQXGkBCDWNQkAIM2qeUiWaw6Udu9cErLrvXzo/wABUaU4uD/W
         FynQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=htZSNJ3oIZAPreJh5xh8HpLPmxowkMMDY5AHwsIFPU4=;
        b=C8Ug9jH40vk/5pOkGXLTSN/WguOooEey+REBbI+2iIUTN2uxPLNkKZGvhY0Sp9gKd7
         Hj1CXoLsgoJ37DgbaGne3XbEL1wq16vuDY/z5IBqdy3pHaGE3X+E0cwtCrIDfehoTLoe
         wRdl6nRWoFt8UBdCJsTcOnoY9Jl8zwNLLlqZxMd2lexFoq/qGZn0XXtmdgYdJMwC9pRg
         WGKt9mJyQmU0GaNw5aVSqT2mh0YzBrFbgRCfxeeV78Cc+Mff8Oh4treBG2ONXdQ86sgF
         APPFD4AplKowj6pOW0fLdgEW4x73zPsJVvLm2SK2pe066HFgkHfloKOGKhKTFZozi3X4
         vpiw==
X-Gm-Message-State: APjAAAVnT4EexUst0eXASEkUF/m/dwJX4gr+i708UbDXnx2quqLLkrkq
        0VS7mvYiimykdhIOxq0vLMA=
X-Google-Smtp-Source: APXvYqxE4NIyH0FkdpRmw+1I/jpCPC2PqJQ0htb5y8JgKDlczdQUhN+kVKDtAJ65cv4fAthi3gls5g==
X-Received: by 2002:a05:620a:90d:: with SMTP id v13mr13066419qkv.332.1581545570921;
        Wed, 12 Feb 2020 14:12:50 -0800 (PST)
Received: from localhost ([2620:10d:c091:500::1:985a])
        by smtp.gmail.com with ESMTPSA id r3sm288026qtc.85.2020.02.12.14.12.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Feb 2020 14:12:50 -0800 (PST)
Date:   Wed, 12 Feb 2020 17:12:49 -0500
From:   Tejun Heo <tj@kernel.org>
To:     madhuparnabhowmik10@gmail.com
Cc:     lizefan@huawei.com, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org, joel@joelfernandes.org,
        rcu@vger.kernel.org, frextrite@gmail.com
Subject: Re: [PATCH] cgroup.c: Use built-in RCU list checking
Message-ID: <20200212221249.GJ80993@mtj.thefacebook.com>
References: <20200118031051.28776-1-madhuparnabhowmik10@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200118031051.28776-1-madhuparnabhowmik10@gmail.com>
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

On Sat, Jan 18, 2020 at 08:40:51AM +0530, madhuparnabhowmik10@gmail.com wrote:
> From: Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>
> 
> list_for_each_entry_rcu has built-in RCU and lock checking.
> Pass cond argument to list_for_each_entry_rcu() to silence
> false lockdep warning when  CONFIG_PROVE_RCU_LIST is enabled
> by default.
> 
> Even though the function css_next_child() already checks if
> cgroup_mutex or rcu_read_lock() is held using
> cgroup_assert_mutex_or_rcu_locked(), there is a need to pass
> cond to list_for_each_entry_rcu() to avoid false positive
> lockdep warning.
> 
> Signed-off-by: Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>

Applied to cgroup/for-5.7.

Thanks.

-- 
tejun
