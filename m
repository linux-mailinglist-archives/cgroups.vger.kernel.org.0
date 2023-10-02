Return-Path: <cgroups-owner@vger.kernel.org>
X-Original-To: lists+cgroups@lfdr.de
Delivered-To: lists+cgroups@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E254D7B4E6C
	for <lists+cgroups@lfdr.de>; Mon,  2 Oct 2023 10:59:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235920AbjJBI75 (ORCPT <rfc822;lists+cgroups@lfdr.de>);
        Mon, 2 Oct 2023 04:59:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235966AbjJBI7z (ORCPT
        <rfc822;cgroups@vger.kernel.org>); Mon, 2 Oct 2023 04:59:55 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D243E9
        for <cgroups@vger.kernel.org>; Mon,  2 Oct 2023 01:59:52 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id 4fb4d7f45d1cf-5363227cc80so6302192a12.3
        for <cgroups@vger.kernel.org>; Mon, 02 Oct 2023 01:59:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696237191; x=1696841991; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=0Aq3VBo7qjCCeRanT50rVNMQkGTY1nNBetMjfH25Y1Y=;
        b=F9je5l33FfdHoTiCcZBgcLRUPLah56SobUhtp9KrV+Vqvpc30UPEawPX50AaiMqoQ7
         zT/S6I2tvEIOmc+OQ7HyyD6OpsIm2ktIVQD7QR7pDqdjPgIi2DXmXXvPR/2sCO+LcyDN
         ODGurFOm6A9UiwevYAMtwj9LA4bHAN+1es/xR4RRXMqWmOholF0tjwl3y837n2eL4/aS
         g7eaczIHIqcRzuGHaU/Q3NtCYO+xHC0ziz34FbsO2UbYv2Yeuo/ADKU43vKTMO2pl4cD
         ZrnvVvmtbIXeSZJxA/4psaYGMPtWkDldBq0P07uGd7zBdLWSPgxQHFDM+MNpVLOcRi5O
         IMAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696237191; x=1696841991;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0Aq3VBo7qjCCeRanT50rVNMQkGTY1nNBetMjfH25Y1Y=;
        b=MDVC7DyccQZ9VBNXWYL9nK0yoQeXqOxoaNwDwulya3XSfQDM7/v4N+HgM7MfHzNFR5
         ewjw5hxG5Sq9sAaWWVG1iUwmWxi9Auajwj9cMOkBqzV0yz41Nz0MVv8hpdJw7bzNdQDr
         HddZzeZ87O+9NDqwxhXzqDqwELFoBMl5uUhbZEUPIrgA7zB0G4hUTgKFRsFDLhL38Nqx
         G8XBIhmmkY0u7oAi6c+ZwVQ7puuOvWuyvDUaQHkb7FNu3DWIkpfKhWGryiekrCcgXr44
         wzKtstVYMYfJt4hLOPBpaYe8yGsRDGLG9qu93Vf39PY5qw9nRlVbeMSMGetVXHWjnDwX
         6VhA==
X-Gm-Message-State: AOJu0YziRSjUQxG06xU2mvNHvHzkIwryho0+6BIWkksXdRJtz9BVXcim
        JKZ5BXsfECdWs4nXNHJ0QAUrhbDLZ7J0re/1S7qGF78V
X-Google-Smtp-Source: AGHT+IFe9vfYszGIqmifCNIgBIKDRYU0O9JcINTWllB2HlPSBtLh4ZD16UErZWHIN1+uWEF/4Rpgv7WjgNZ0GpEPvz8=
X-Received: by 2002:aa7:c157:0:b0:523:102f:3ce1 with SMTP id
 r23-20020aa7c157000000b00523102f3ce1mr10251146edp.10.1696237190736; Mon, 02
 Oct 2023 01:59:50 -0700 (PDT)
MIME-Version: 1.0
From:   Felip Moll <lipixx@gmail.com>
Date:   Mon, 2 Oct 2023 10:59:34 +0200
Message-ID: <CAOv3p80vCV1_FeynQ_sZhzYbif_-4k4odZHex9NbhzuZ204gLg@mail.gmail.com>
Subject: VSZ from cgroup interfaces
To:     cgroups@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <cgroups.vger.kernel.org>
X-Mailing-List: cgroups@vger.kernel.org

Hello,

I am trying to get the VSZ of the pids of a cgroup and its
descendants, but I am not finding which is the best way to achieve
this in any of the interfaces of cgroups. In kernel code I can see how
memory.current includes anon and pagecache (file), and
memory.swap.current includes all the swap. I also see how pages
accounted in memory.current are discharged when they are charged to
memory.swap.current.

Also, I tested with a simple program which just does a malloc uses
VSZ. I get the value from /proc, but I see no way to get this value in
cgroups (e.g. from memory.stat fields).

Does cgroups account for virtual memory? Is it too expensive to
account for it? I cannot find it by reading the kernel but I might be
wrong.

Thanks
Pd. I don't know where to ask it, so please forward me to the correct
mailing list/source if this is not the one.
