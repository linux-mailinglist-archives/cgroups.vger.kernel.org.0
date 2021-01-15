Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F13E42F7078
	for <lists+cgroups@lfdr.de>; Fri, 15 Jan 2021 03:20:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732012AbhAOCUV (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Thu, 14 Jan 2021 21:20:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732011AbhAOCUU (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Thu, 14 Jan 2021 21:20:20 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1E2AC061575;
        Thu, 14 Jan 2021 18:19:39 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id c7so7909059edv.6;
        Thu, 14 Jan 2021 18:19:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fI/1lXfnira7lqXCcxJnPYuJ/g5t5oZZRm+ZWpb4+FI=;
        b=VGOuUg1lWUtN6AREorPyWbQWKGBcytb/F+GaLsKenHyIPlKz+HUKMT4Kl4Sge2dUhU
         XDNiOD0jPt6rr8C4CQXlUqloEimlDqMXEXjAeGQcC4Mi9pvz2iAcvpwxXsf3RoarjE9g
         +nMD/72CnC2OUF7s+FLt6PGhxn+wwoM3/vQdujxJtk8wq0a7ZSfkuch8wQrI+asDCEw6
         mUVOzy/QttEfGvP0E9sY5arphfqahtgBM15jB9KRzqTMJLlCC2Qcnt0Wq3MI/7NflSOI
         055r+5Rb0saSZyD2c/kNmdFKtGwkEVQCyH3zEsKJed0QYiGMO0fERnbthvJYK9O07bIO
         bNdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fI/1lXfnira7lqXCcxJnPYuJ/g5t5oZZRm+ZWpb4+FI=;
        b=fDvVYSgtb8T8OX0wdqd0nDvr50O3a8xCWW2LGhHnxwICRJVQKy5GI5EwVVGilg+guW
         ekzzs+T8f4yuiiAfSsCantjYn2jg8WD1DemTXZQFv+qmgdcH8WBufvogaQxrzrwso666
         zJRb8v1FOLUT5dTNNyU9MV7A+B0AS8Qau6NInvsJ5tPvIbd7022Mxyc5c5ne/vn63vl/
         zq4bzFDhgNeelgCGrf+RP1KjMKobW7EQ6sOuTtgdppR/cqjWuxT/eHkH+SZe/rf9nTlj
         wj/xIpTl3Nc2wMi7Mx5a0fpZ44vD3+aqo2Lz3ICuHtTlu4J0K0pm/3OiX5kvE8LhihCK
         99QA==
X-Gm-Message-State: AOAM5336Vm3oc7Qbd0DeHSYrjo8Sfx6TK1ga/QoiMG3TaDWsJYpma668
        ua38hBpmBnavhn/aKlYQcOXWNYJerHobUXE9pqwcDkeV
X-Google-Smtp-Source: ABdhPJwHsxft8uW3qgjkt20wAlHjG3MqNbxNTgCfw4SZ08xZJ+KWljc1nKDh4iCz4SY4AWQYa3is3qhIb75jlgwySb8=
X-Received: by 2002:a05:6402:487:: with SMTP id k7mr7894363edv.130.1610677178473;
 Thu, 14 Jan 2021 18:19:38 -0800 (PST)
MIME-Version: 1.0
References: <20210103024846.GA15337@haolee.github.io> <YAA8qyBUAurgCeEz@blackbook>
In-Reply-To: <YAA8qyBUAurgCeEz@blackbook>
From:   Hao Lee <haolee.swjtu@gmail.com>
Date:   Fri, 15 Jan 2021 10:19:25 +0800
Message-ID: <CA+PpKPnmzzdH4Wbb5LWT0+cjbS9=cwcxuPRMHf7GuukWdTfVuA@mail.gmail.com>
Subject: Re: [PATCH] cgroup: Remove unnecessary call to strstrip()
To:     =?UTF-8?Q?Michal_Koutn=C3=BD?= <mkoutny@suse.com>
Cc:     tj@kernel.org, lizefan@huawei.com,
        Johannes Weiner <hannes@cmpxchg.org>, cgroups@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

> Perhaps the code be then simplified a bit
>
> -- >8 --
> From: =?UTF-8?q?Michal=20Koutn=C3=BD?= <mkoutny@suse.com>
> Date: Thu, 14 Jan 2021 13:23:39 +0100
> Subject: [PATCH] cgroup: cgroup.{procs,threads} factor out common parts
> MIME-Version: 1.0
> Content-Type: text/plain; charset=UTF-8
> Content-Transfer-Encoding: 8bit
>
> The functions cgroup_threads_start and cgroup_procs_start are almost
> identical. In order to reduce duplication, factor out the common code in
> similar fashion we already do for other threadgroup/task functions. No
> functional changes are intended.

Nice work. I didn't realize this simplification :)

Regards,
Hao Lee
