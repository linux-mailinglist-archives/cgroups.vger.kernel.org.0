Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 79FB61B7B4D
	for <lists+cgroups@lfdr.de>; Fri, 24 Apr 2020 18:18:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728083AbgDXQSL (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Fri, 24 Apr 2020 12:18:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726753AbgDXQSL (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Fri, 24 Apr 2020 12:18:11 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD797C09B046
        for <cgroups@vger.kernel.org>; Fri, 24 Apr 2020 09:18:07 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id j1so11589849wrt.1
        for <cgroups@vger.kernel.org>; Fri, 24 Apr 2020 09:18:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=zJcrLGlOEczpFL7vIG+WK7PlgapGjJdWoYcFezBgv4g=;
        b=XWmnpbGsttaKARXWRnwKO/pGb3rM7adDuqQPCcz4VI6c0H0ZSojHnUmWJ2X1aaoIsF
         luq5AH/35nGsivxgzngAaxKvcHY/KzNtbmHNSLkOBbC6tUS7MDCnDD5hZEe+y6r5MpfV
         OeZ4TDNFP5Rk4R9mR9EANQSPodBipORrdm0zDouuJsPKkZddiBg4lOszyoiBWKuOvPpO
         S+UNvGofzdZg9YhzbhRrCbf1Ogk1W317JN3Hm4lB6/X+0RNbKlw2H2JPdEPtyN+gM/cC
         D+q3hOy7GphCcakXyQpcUtwW3PEM+SEbC8TEnPTUMKDlDm91NDF2AtxFGePQxGCqqbc0
         YR4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=zJcrLGlOEczpFL7vIG+WK7PlgapGjJdWoYcFezBgv4g=;
        b=pbytvkJ+1aLrxf1yO6mFPtpJ0DqGwmJXT+Nsp8ptbVdjDiGt6sAUKE/eeZo+9PGytK
         WBtwe/ogssnZ9UXdOqE9Eeq1fNmWi6xqBkZQtHS/g5LEW9+YFFizj9bQZXnk4Flfdy/e
         38B1sezNzPoEqYWwZrlKTQF2ntw25MGh0xIv5+ayRyjUUAnr4DxeB0r43baUHlvt4nLF
         iy6SRSDCDrOTjNn8GoG0N/9oNncgdO17vvvL9oDGysC/Ly8VwFAFS0hfZWqz4IdXdUlO
         DeoF4AIyOi6tnjO3sPowUQgoksLJhoQgyvxQqxI9Kcx52QO2Qz5cVYbK5HQdI9WXiuYf
         HZfg==
X-Gm-Message-State: AGi0PuYkn3KStsm1EJE0GQhzUFyNdmYn6EEa87azVc4v7kYV2qxGAXIg
        wxAE78QJqFplJ/76KwdNUHZDYJ4+BWc3A9Nogu9mLi72SZw=
X-Google-Smtp-Source: APiQypLvZtUn0drAqub2068xxuoqBGh+MikuPQwW8LAFbki+QhIWcnF82p/znDgJDfcJoRpo3KKJgtR1lgTwG8X6nAk=
X-Received: by 2002:adf:f4cb:: with SMTP id h11mr7881538wrp.191.1587745086218;
 Fri, 24 Apr 2020 09:18:06 -0700 (PDT)
MIME-Version: 1.0
From:   Kenny Ho <y2kenny@gmail.com>
Date:   Fri, 24 Apr 2020 12:17:55 -0400
Message-ID: <CAOWid-dSF0X3pa6ud2-ndYzJdohuOBewfcEZcG7pQ8q=fZh14g@mail.gmail.com>
Subject: Question about BPF_MAP_TYPE_CGROUP_STORAGE
To:     cgroups@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: cgroups-owner@vger.kernel.org
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hi,

From the documentation, eBPF maps allow sharing of data between eBPF
kernel programs, kernel and user space applications.  Does that
applies to BPF_MAP_TYPE_CGROUP_STORAGE?  If so, what is the correct
way to access the cgroup storage from the linux kernel? I have been
reading the __cgroup_bpf_attach function and how the storage are
allocated and linked but I am not sure if I am on the right path.

Regards,
Kenny
